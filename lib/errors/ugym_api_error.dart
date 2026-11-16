import 'package:dio/dio.dart';

/// Typed API and network exception mapped from backend responses.
final class UgymApiException implements Exception {
  const UgymApiException({
    required this.code,
    required this.message,
    this.statusCode,
    this.fieldErrors = const <String, List<String>>{},
    this.isNetworkError = false,
  });

  final int? statusCode;
  final String code;
  final String message;
  final Map<String, List<String>> fieldErrors;
  final bool isNetworkError;

  bool get isUnauthorized =>
      statusCode == 401 || code == 'UNAUTHENTICATED' || code == 'UNAUTHORIZED';

  bool get isForbidden => statusCode == 403 || code == 'FORBIDDEN';

  bool get isSubscriptionExpired => code == 'SUBSCRIPTION_EXPIRED';

  bool get isGeoLocationRequired => code == 'GEO_LOCATION_REQUIRED';

  bool get isValidationFailed =>
      statusCode == 422 ||
      code == 'VALIDATION_FAILED' ||
      fieldErrors.isNotEmpty;

  @override
  String toString() =>
      'UgymApiException(statusCode: $statusCode, code: $code, message: $message)';
}

/// Maps [DioException] and raw API error payloads to [UgymApiException].
abstract final class UgymErrorMapper {
  static UgymApiException fromDioException(DioException exception) {
    final existing = exception.error;
    if (existing is UgymApiException) {
      return existing;
    }

    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return const UgymApiException(
          code: 'NETWORK_ERROR',
          message: 'Network error. Please check your internet connection.',
          isNetworkError: true,
        );
      case DioExceptionType.cancel:
        return const UgymApiException(
          code: 'REQUEST_CANCELLED',
          message: 'Request was cancelled.',
          isNetworkError: true,
        );
      case DioExceptionType.badCertificate:
        return const UgymApiException(
          code: 'TLS_ERROR',
          message: 'Secure connection could not be verified.',
          isNetworkError: true,
        );
      case DioExceptionType.badResponse:
      case DioExceptionType.unknown:
        final response = exception.response;
        if (response == null && exception.type == DioExceptionType.unknown) {
          return const UgymApiException(
            code: 'NETWORK_ERROR',
            message: 'Network error. Please check your internet connection.',
            isNetworkError: true,
          );
        }
        return fromResponse(
          statusCode: response?.statusCode,
          data: response?.data,
          fallbackMessage: exception.message ?? 'Request failed.',
        );
    }
  }

  static UgymApiException fromResponse({
    int? statusCode,
    Object? data,
    String fallbackMessage = 'Request failed.',
  }) {
    String code = _defaultCodeForStatus(statusCode);
    String message = fallbackMessage;
    Map<String, List<String>> fieldErrors = const <String, List<String>>{};

    if (data is Map<Object?, Object?>) {
      final rawRootMessage = data['message'];
      if (rawRootMessage is String && rawRootMessage.trim().isNotEmpty) {
        message = rawRootMessage;
      }

      fieldErrors = _parseFieldErrors(data['errors']);

      final rawError = data['error'];
      if (rawError is Map<Object?, Object?>) {
        final rawCode = rawError['code'];
        if (rawCode is String && rawCode.trim().isNotEmpty) {
          code = rawCode;
        }

        final rawMessage = rawError['message'];
        if (rawMessage is String && rawMessage.trim().isNotEmpty) {
          message = rawMessage;
        }

        if (fieldErrors.isEmpty) {
          final fromDetails = _parseFieldErrors(rawError['details']);
          fieldErrors = fromDetails.isNotEmpty
              ? fromDetails
              : _parseFieldErrors(rawError['errors']);
        }
      }
    }

    return UgymApiException(
      statusCode: statusCode,
      code: code,
      message: message,
      fieldErrors: fieldErrors,
    );
  }

  static Map<String, List<String>> _parseFieldErrors(Object? raw) {
    if (raw is! Map<Object?, Object?>) {
      return const <String, List<String>>{};
    }

    final parsed = <String, List<String>>{};
    for (final entry in raw.entries) {
      final key = entry.key;
      final value = entry.value;
      if (key is! String) {
        continue;
      }
      if (value is List<Object?>) {
        final messages = value.whereType<String>().toList(growable: false);
        if (messages.isNotEmpty) {
          parsed[key] = messages;
        }
      } else if (value is String && value.trim().isNotEmpty) {
        parsed[key] = <String>[value];
      }
    }
    return Map<String, List<String>>.unmodifiable(parsed);
  }

  static String _defaultCodeForStatus(int? statusCode) {
    return switch (statusCode) {
      400 => 'BAD_REQUEST',
      401 => 'UNAUTHENTICATED',
      403 => 'FORBIDDEN',
      404 => 'NOT_FOUND',
      409 => 'CONFLICT',
      422 => 'VALIDATION_FAILED',
      429 => 'TOO_MANY_REQUESTS',
      _ =>
        statusCode != null && statusCode >= 500
            ? 'SERVER_ERROR'
            : 'UNKNOWN_ERROR',
    };
  }
}
