import 'dart:math';

import 'package:dio/dio.dart';

import '../errors/ugym_api_error.dart';
import '../storage/token_storage.dart';

/// RFC 4122 UUID v4 generator backed by [Random.secure].
abstract final class UgymUuid {
  static final Random _random = Random.secure();

  static String v4() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;

    final buffer = StringBuffer();
    for (var i = 0; i < 16; i++) {
      if (i == 4 || i == 6 || i == 8 || i == 10) {
        buffer.write('-');
      }
      buffer.write(bytes[i].toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString();
  }
}

/// Injects Auth, Accept-Language, X-Request-Id, and Idempotency-Key headers.
final class UgymNetworkInterceptor extends Interceptor {
  UgymNetworkInterceptor({
    required this.tokenStorage,
    String Function()? localeProvider,
    this.onUnauthorized,
    this.onSubscriptionExpired,
  }) : _localeProvider = localeProvider ?? _defaultLocale;

  static String _defaultLocale() => 'ru';

  final TokenStorage tokenStorage;
  final String Function() _localeProvider;
  final void Function()? onUnauthorized;
  final void Function()? onSubscriptionExpired;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers.putIfAbsent('Accept', () => 'application/json');
    options.headers['Accept-Language'] = _localeProvider();
    options.headers.putIfAbsent('X-Request-Id', UgymUuid.v4);

    if (options.extra['idempotent'] == true &&
        options.headers['Idempotency-Key'] == null) {
      options.headers['Idempotency-Key'] = UgymUuid.v4();
    }

    if (options.extra['skipAuth'] != true &&
        options.headers['Authorization'] == null) {
      final token = await tokenStorage.readToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final apiError = UgymErrorMapper.fromDioException(err);
    if (apiError.isUnauthorized) {
      onUnauthorized?.call();
    }
    if (apiError.isSubscriptionExpired) {
      onSubscriptionExpired?.call();
    }
    handler.next(err.copyWith(error: apiError));
  }
}
