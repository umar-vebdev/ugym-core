import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugym_core/ugym_core.dart';

final class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this._handler);

  final Future<ResponseBody> Function(RequestOptions options) _handler;
  final List<RequestOptions> capturedRequests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    capturedRequests.add(options);
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _jsonResponse(int statusCode, Map<String, Object?> body) {
  return ResponseBody.fromString(
    jsonEncode(body),
    statusCode,
    headers: <String, List<String>>{
      Headers.contentTypeHeader: <String>[Headers.jsonContentType],
    },
  );
}

void main() {
  group('InMemoryTokenStorage', () {
    test('reads, writes, deletes, and clears values', () async {
      final storage = InMemoryTokenStorage();
      expect(await storage.readToken(), isNull);

      await storage.writeToken('secret-token');
      await storage.write('kiosk_pin', '1234');
      expect(await storage.readToken(), 'secret-token');
      expect(await storage.read('kiosk_pin'), '1234');

      await storage.deleteToken();
      expect(await storage.readToken(), isNull);
      expect(await storage.read('kiosk_pin'), '1234');

      await storage.clearAll();
      expect(await storage.read('kiosk_pin'), isNull);
    });
  });

  group('UgymUuid', () {
    test('generates valid unique RFC 4122 v4 UUIDs', () {
      final uuidPattern = RegExp(
        r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
      );

      final first = UgymUuid.v4();
      final second = UgymUuid.v4();

      expect(first, matches(uuidPattern));
      expect(second, matches(uuidPattern));
      expect(first, isNot(equals(second)));
    });
  });

  group('UgymHttpClient & UgymNetworkInterceptor', () {
    test(
      'injects Auth, Accept-Language, X-Request-Id, and Idempotency-Key',
      () async {
        final storage = InMemoryTokenStorage(initialToken: 'sanctum-token-1');
        var locale = 'tg';
        final client = UgymHttpClient(
          baseUrl: 'https://api.ugym.tj/api/v1',
          tokenStorage: storage,
          localeProvider: () => locale,
        );
        final adapter = _FakeAdapter(
          (_) async => _jsonResponse(200, <String, Object?>{'data': null}),
        );
        client.dio.httpClientAdapter = adapter;

        await client.dio.post<Object?>(
          '/client/visits/check-in',
          options: UgymHttpClient.idempotentOptions(),
        );

        final req1 = adapter.capturedRequests.single;
        expect(req1.headers['Authorization'], 'Bearer sanctum-token-1');
        expect(req1.headers['Accept-Language'], 'tg');
        expect(req1.headers['X-Request-Id'], isA<String>());
        expect(req1.headers['Idempotency-Key'], isA<String>());

        // Explicit Idempotency-Key is preserved across retries, and skipAuth omits token.
        locale = 'ru';
        const pinnedKey = '00000000-0000-4000-8000-000000000001';
        await client.dio.post<Object?>(
          '/auth/login',
          options: UgymHttpClient.idempotentOptions(
            idempotencyKey: pinnedKey,
            base: Options(extra: <String, Object?>{'skipAuth': true}),
          ),
        );

        final req2 = adapter.capturedRequests.last;
        expect(req2.headers.containsKey('Authorization'), isFalse);
        expect(req2.headers['Accept-Language'], 'ru');
        expect(req2.headers['Idempotency-Key'], pinnedKey);
      },
    );

    test(
      'maps API error payloads and fires unauthorized/subscription callbacks',
      () async {
        final storage = InMemoryTokenStorage(initialToken: 'expired');
        var unauthorizedCalls = 0;
        var subscriptionExpiredCalls = 0;

        final client = UgymHttpClient(
          baseUrl: 'https://api.ugym.tj/api/v1',
          tokenStorage: storage,
          onUnauthorized: () => unauthorizedCalls++,
          onSubscriptionExpired: () => subscriptionExpiredCalls++,
        );

        client.dio.httpClientAdapter = _FakeAdapter((options) async {
          if (options.path.endsWith('/401')) {
            return _jsonResponse(401, <String, Object?>{
              'error': <String, Object?>{
                'code': 'UNAUTHENTICATED',
                'message': 'Unauthenticated.',
              },
            });
          }
          if (options.path.endsWith('/403')) {
            return _jsonResponse(403, <String, Object?>{
              'error': <String, Object?>{
                'code': 'SUBSCRIPTION_EXPIRED',
                'message': 'Subscription expired.',
              },
            });
          }
          return _jsonResponse(422, <String, Object?>{
            'message': 'The given data was invalid.',
            'errors': <String, Object?>{
              'email': <String>['The email field is required.'],
            },
          });
        });

        await expectLater(
          () => client.dio.get<Object?>('/401'),
          throwsA(
            isA<DioException>().having(
              (e) => e.error,
              'error',
              isA<UgymApiException>()
                  .having((a) => a.isUnauthorized, 'isUnauthorized', isTrue)
                  .having((a) => a.code, 'code', 'UNAUTHENTICATED'),
            ),
          ),
        );
        expect(unauthorizedCalls, 1);

        await expectLater(
          () => client.dio.post<Object?>('/403'),
          throwsA(
            isA<DioException>().having(
              (e) => e.error,
              'error',
              isA<UgymApiException>().having(
                (a) => a.isSubscriptionExpired,
                'isSubscriptionExpired',
                isTrue,
              ),
            ),
          ),
        );
        expect(subscriptionExpiredCalls, 1);

        await expectLater(
          () => client.dio.post<Object?>('/422'),
          throwsA(
            isA<DioException>().having(
              (e) => e.error,
              'error',
              isA<UgymApiException>()
                  .having(
                    (a) => a.isValidationFailed,
                    'isValidationFailed',
                    true,
                  )
                  .having(
                    (a) => a.fieldErrors['email'],
                    'email errors',
                    <String>['The email field is required.'],
                  ),
            ),
          ),
        );
      },
    );
  });

  group('UgymErrorMapper', () {
    test('maps timeout DioException to network UgymApiException', () {
      final dioErr = DioException(
        requestOptions: RequestOptions(path: '/health'),
        type: DioExceptionType.connectionTimeout,
      );

      final mapped = UgymErrorMapper.fromDioException(dioErr);
      expect(mapped.code, 'NETWORK_ERROR');
      expect(mapped.isNetworkError, isTrue);
    });
  });

  group('UgymHealthService', () {
    test('checks /health without auth header and parses status', () async {
      final client = UgymHttpClient(
        baseUrl: 'https://api.ugym.tj/api/v1',
        tokenStorage: InMemoryTokenStorage(initialToken: 'secret-token'),
      );
      final adapter = _FakeAdapter(
        (_) async => _jsonResponse(200, <String, Object?>{
          'app': 'ok',
          'database': 'ok',
          'redis': 'ok',
        }),
      );
      client.dio.httpClientAdapter = adapter;

      final service = UgymHealthService(httpClient: client);
      final status = await service.check();

      expect(status.isHealthy, isTrue);
      expect(status.app, 'ok');
      expect(status.database, 'ok');
      expect(status.redis, 'ok');
      expect(
        adapter.capturedRequests.single.headers.containsKey('Authorization'),
        isFalse,
      );
    });
  });
}
