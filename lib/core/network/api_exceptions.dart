class ApiException implements Exception {
  final String? message;
  final int? statusCode;

  ApiException({this.message, this.statusCode});

  @override
  String toString() => message ?? 'Unknown error occurred';
}

class NetworkException extends ApiException {
  NetworkException() : super(message: 'No internet connection');
}

class TimeoutException extends ApiException {
  TimeoutException() : super(message: 'Connection timeout');
}

class BadRequestException extends ApiException {
  BadRequestException([String? message])
      : super(message: message ?? 'Bad request');
}

class UnauthorizedException extends ApiException {
  UnauthorizedException() : super(message: 'Unauthorized');
}

class ForbiddenException extends ApiException {
  ForbiddenException() : super(message: 'Forbidden');
}

class NotFoundException extends ApiException {
  NotFoundException() : super(message: 'Not found');
}

class ServerException extends ApiException {
  ServerException() : super(message: 'Server error');
}

class RequestCancelledException extends ApiException {
  RequestCancelledException() : super(message: 'Request cancelled');
}

class UnknownException extends ApiException {
  UnknownException() : super(message: 'Unknown error occurred');
}
