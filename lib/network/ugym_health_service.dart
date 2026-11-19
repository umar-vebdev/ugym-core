import 'package:dio/dio.dart';

import 'ugym_http_client.dart';

/// Health status payload returned by `GET /api/v1/health`.
final class UgymHealthStatus {
  const UgymHealthStatus({
    required this.app,
    required this.database,
    required this.redis,
  });

  final String app;
  final String database;
  final String redis;

  bool get isHealthy => app == 'ok' && database == 'ok' && redis == 'ok';

  static UgymHealthStatus fromJson(Object? raw) {
    if (raw is! Map<Object?, Object?>) {
      return const UgymHealthStatus(
        app: 'error',
        database: 'error',
        redis: 'error',
      );
    }

    return UgymHealthStatus(
      app: raw['app'] is String ? raw['app'] as String : 'error',
      database: raw['database'] is String ? raw['database'] as String : 'error',
      redis: raw['redis'] is String ? raw['redis'] as String : 'error',
    );
  }
}

/// Shared service to check backend availability via `GET /api/v1/health`.
final class UgymHealthService {
  const UgymHealthService({required this.httpClient});

  final UgymHttpClient httpClient;

  Future<UgymHealthStatus> check() async {
    final response = await httpClient.dio.get<Object?>(
      '/health',
      options: Options(extra: const <String, Object?>{'skipAuth': true}),
    );
    return UgymHealthStatus.fromJson(response.data);
  }
}
