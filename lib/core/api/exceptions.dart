/// API 异常定义

class ApiException implements Exception {
  final int code;
  final String message;
  final dynamic details;

  ApiException({
    required this.code,
    required this.message,
    this.details,
  });

  @override
  String toString() => 'ApiException($code): $message';
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);

  @override
  String toString() => 'TimeoutException: $message';
}
