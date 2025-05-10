import 'package:dartz/dartz.dart';
import 'package:super_mall/core/error/failures.dart';
import 'package:super_mall/core/network/api_client.dart';
import 'package:super_mall/core/network/api_constants.dart';
import 'package:super_mall/core/network/api_exceptions.dart';
import 'package:super_mall/core/network/network_info.dart';
import 'package:super_mall/features/auth/register/data/model/register.dart';

abstract class RegisterRepositoryBase {
  Future<Either<Failure, RegistrationModel>> register(
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
  Future<Either<Failure, RegistrationModel>> register(
      RegistrationModel registerData) async {
    if (!await _networkInfo.isConnected) {
      return Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      final response = await _apiClient.post(
        ApiConstants.register,
        data: registerData.toJson(),
      );
      return Right(RegistrationModel.fromJson(response.data));
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Unknown error'));
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
