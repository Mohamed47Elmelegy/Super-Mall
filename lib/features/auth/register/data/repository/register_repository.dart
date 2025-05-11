import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:super_mall/core/error/failures.dart';
import 'package:super_mall/core/network/api_client.dart';
import 'package:super_mall/core/network/api_constants.dart';
import 'package:super_mall/core/network/api_exceptions.dart';
import 'package:super_mall/core/network/network_info.dart';
import 'package:super_mall/features/auth/register/data/model/register.dart';

abstract class RegisterRepositoryBase {
  Future<Either<Failure, RegisterResponseModel>> register(
      RegistrationModel registerData);
  Future<Either<Failure, void>> registerWithGoogle();
  Future<Either<Failure, void>> registerWithFacebook();
}

class RegisterRepository implements RegisterRepositoryBase {
  final ApiClient _apiClient;
  final NetworkInfo _networkInfo;

  RegisterRepository({
    required ApiClient apiClient,
    required NetworkInfo networkInfo,
  })  : _apiClient = apiClient,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, RegisterResponseModel>> register(
      RegistrationModel registerData) async {
    if (!await _networkInfo.isConnected) {
      log('=== Network Error: No Internet Connection ===');
      return Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      log('=== Register Request Data ===');
      log('URL: ${ApiConstants.baseUrl}${ApiConstants.register}');
      log('Request Data: ${registerData.toJson()}');
      log('Headers: ${ApiConstants.headers}');
      log('===========================');

      final response = await _apiClient.post(
        ApiConstants.register,
        data: registerData.toJson(),
      );

      log('=== Register Response Data ===');
      log('Status Code: ${response.statusCode}');
      log('Response Data: ${response.data}');
      log('============================');

      if (response.data == null) {
        log('=== Error: Response data is null ===');
        return Left(ServerFailure(message: 'Server returned null response'));
      }

      return Right(RegisterResponseModel.fromJson(response.data));
    } on ApiException catch (e) {
      log('=== Register Error Data ===');
      log('Error Message: ${e.message}');
      log('Status Code: ${e.statusCode}');
      log('Response Data: ${e.response?.data}');
      log('==========================');

      if (e.statusCode == 422) {
        // Validation Error
        final errors = e.response?.data['errors'] as Map<String, dynamic>?;
        if (errors != null) {
          final errorMessage = errors.values.first.toString();
          return Left(ServerFailure(message: errorMessage));
        }
      }

      return Left(ServerFailure(message: e.message ?? 'Unknown error'));
    } catch (e, stackTrace) {
      log('=== Unexpected Error ===');
      log('Error: $e');
      log('Stack Trace: $stackTrace');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerWithGoogle() async {
    if (!await _networkInfo.isConnected) {
      return Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      await _apiClient.post(ApiConstants.googleRegister);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<Failure, void>> registerWithFacebook() async {
    if (!await _networkInfo.isConnected) {
      return Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      await _apiClient.post(ApiConstants.facebookRegister);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Unknown error'));
    }
  }
}
