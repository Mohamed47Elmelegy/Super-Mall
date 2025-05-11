import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String? message;
  final int? statusCode;
  final Response? response;

  ApiException({
    this.message,
    this.statusCode,
    this.response,
  });

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
  BadRequestException([String? message, Response? response])
      : super(message: message ?? 'Bad request', response: response);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([Response? response])
      : super(message: 'Unauthorized', response: response);
}

class ForbiddenException extends ApiException {
  ForbiddenException([Response? response])
      : super(message: 'Forbidden', response: response);
}

class NotFoundException extends ApiException {
  NotFoundException([Response? response])
      : super(message: 'Not found', response: response);
}

class ServerException extends ApiException {
  ServerException([Response? response])
      : super(message: 'Server error', response: response);
}

class RequestCancelledException extends ApiException {
  RequestCancelledException() : super(message: 'Request cancelled');
}

class UnknownException extends ApiException {
  UnknownException([Response? response])
      : super(message: 'Unknown error occurred', response: response);
}
