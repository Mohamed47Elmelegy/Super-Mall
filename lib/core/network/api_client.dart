import 'dart:developer';

import 'package:dio/dio.dart';
import 'api_constants.dart';
import 'api_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  late final Dio _dio;

  Dio get dio => _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: ApiConstants.headers,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    _dio.interceptors.addAll([
      _LoggingInterceptor(),
      _ErrorInterceptor(),
      _AuthInterceptor(),
    ]);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException();
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);
      case DioExceptionType.cancel:
        return RequestCancelledException();
      default:
        return NetworkException();
    }
  }

  Exception _handleResponseError(Response? response) {
    if (response == null) return UnknownException();

    switch (response.statusCode) {
      case 400:
        return BadRequestException(response.data['message'], response);
      case 401:
        return UnauthorizedException(response);
      case 403:
        return ForbiddenException(response);
      case 404:
        return NotFoundException(response);
      case 500:
        return ServerException(response);
      default:
        return UnknownException(response);
    }
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // log('┌------------------------------------------------------------------------------');
    // log('| Request: ${options.method} ${options.uri}');
    // log('| Headers:');
    // options.headers.forEach((key, value) {
    //   log('| \t$key: $value');
    // });
    // log('| Body: ${options.data}');
    // log('└------------------------------------------------------------------------------');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // log('┌------------------------------------------------------------------------------');
    // log('| Response [${response.statusCode}] ${response.requestOptions.uri}');
    // log('| Headers:');
    // response.headers.forEach((key, values) {
    //   log('| \t$key: ${values.join(',')}');
    // });
    // log('| Body: ${response.data}');
    // log('└------------------------------------------------------------------------------');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // log('┌------------------------------------------------------------------------------');
    // log('| Error: ${err.type}');
    // log('| ${err.requestOptions.method} ${err.requestOptions.uri}');
    // log('| Status Code: ${err.response?.statusCode}');
    // log('| Message: ${err.message}');
    // log('| Response: ${err.response?.data}');
    // log('└------------------------------------------------------------------------------');
    super.onError(err, handler);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: TimeoutException(),
          type: DioExceptionType.connectionTimeout,
        ));
      case DioExceptionType.badResponse:
        final customError = _handleResponseError(err.response);
        return handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: customError,
          response: err.response,
          type: DioExceptionType.badResponse,
        ));
      case DioExceptionType.cancel:
        return handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: RequestCancelledException(),
          type: DioExceptionType.cancel,
        ));
      default:
        return handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: NetworkException(),
          type: DioExceptionType.unknown,
        ));
    }
  }

  Exception _handleResponseError(Response? response) {
    if (response == null) return UnknownException();

    switch (response.statusCode) {
      case 400:
        return BadRequestException(response.data['message'], response);
      case 401:
        return UnauthorizedException(response);
      case 403:
        return ForbiddenException(response);
      case 404:
        return NotFoundException(response);
      case 500:
        return ServerException(response);
      default:
        return UnknownException(response);
    }
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) async {
  //   if (err.response?.statusCode == 401) {
  //     // Handle token refresh or logout
  //     await _refreshToken();
  //     return handler.resolve(await _retry(err.requestOptions));
  //   }
  //   super.onError(err, handler);
  // }
}
