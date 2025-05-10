import 'package:dartz/dartz.dart';
import 'package:super_mall/core/error/failures.dart';
import 'package:super_mall/core/network/api_client.dart';
import 'package:super_mall/core/network/api_constants.dart';
import 'package:super_mall/core/network/network_info.dart';
import 'package:super_mall/features/auth/login/data/model/login.dart';
import 'package:super_mall/core/network/api_exceptions.dart';

abstract class LoginRepositoryBase {
  Future<Either<Failure, UserLoginModel>> login(UserLoginModel loginData);
  Future<Either<Failure, void>> loginWithGoogle();
  Future<Either<Failure, void>> loginWithFacebook();
  Future<Either<Failure, void>> resetPassword(String email);
}

class LoginRepository implements LoginRepositoryBase {
  final ApiClient _apiClient;
  final NetworkInfo _networkInfo;

  LoginRepository({
    required ApiClient apiClient,
    required NetworkInfo networkInfo,
  })  : _apiClient = apiClient,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, UserLoginModel>> login(
      UserLoginModel loginData) async {
    if (!await _networkInfo.isConnected) {
      return Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      final response = await _apiClient.post(
        ApiConstants.login,
        data: loginData.toJson(),
      );
      return Right(UserLoginModel.fromJson(response.data));
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<Failure, void>> loginWithGoogle() async {
    if (!await _networkInfo.isConnected) {
      return Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      await _apiClient.post(ApiConstants.googleLogin);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<Failure, void>> loginWithFacebook() async {
    if (!await _networkInfo.isConnected) {
      return Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      await _apiClient.post(ApiConstants.facebookLogin);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Unknown error'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    if (!await _networkInfo.isConnected) {
      return Left(NetworkFailure(message: 'No internet connection'));
    }

    try {
      await _apiClient.post(
        ApiConstants.forgotPassword,
        data: {'email': email},
      );
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Unknown error'));
    }
  }
}
