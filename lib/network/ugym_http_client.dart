import 'package:dio/dio.dart';

import '../storage/token_storage.dart';
import 'ugym_interceptors.dart';

/// Preconfigured Dio HTTP client shared across uGym and uGym Business.
final class UgymHttpClient {
  UgymHttpClient({
    required String baseUrl,
    required TokenStorage tokenStorage,
    String Function()? localeProvider,
    void Function()? onUnauthorized,
    void Function()? onSubscriptionExpired,
    Duration connectTimeout = const Duration(seconds: 15),
    Duration receiveTimeout = const Duration(seconds: 20),
    Duration sendTimeout = const Duration(seconds: 20),
    Dio? dio,
  }) : dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: baseUrl,
               connectTimeout: connectTimeout,
               receiveTimeout: receiveTimeout,
               sendTimeout: sendTimeout,
               headers: const <String, Object?>{
                 'Accept': 'application/json',
                 'Content-Type': 'application/json',
               },
             ),
           ) {
    this.dio.interceptors.add(
      UgymNetworkInterceptor(
        tokenStorage: tokenStorage,
        localeProvider: localeProvider,
        onUnauthorized: onUnauthorized,
        onSubscriptionExpired: onSubscriptionExpired,
      ),
    );
  }

  final Dio dio;

  /// Marks a request as idempotent and optionally pins a stable [idempotencyKey].
  static Options idempotentOptions({String? idempotencyKey, Options? base}) {
    final mergedExtra = <String, Object?>{...?base?.extra, 'idempotent': true};
    final mergedHeaders = <String, Object?>{...?base?.headers};
    if (idempotencyKey != null && idempotencyKey.isNotEmpty) {
      mergedHeaders['Idempotency-Key'] = idempotencyKey;
    }

    if (base == null) {
      return Options(extra: mergedExtra, headers: mergedHeaders);
    }

    return base.copyWith(extra: mergedExtra, headers: mergedHeaders);
  }
}
