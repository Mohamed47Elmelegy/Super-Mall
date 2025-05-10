import 'package:dartz/dartz.dart';
import 'package:super_mall/core/error/failures.dart';
import 'package:super_mall/core/network/api_client.dart';
import 'package:super_mall/core/network/api_constants.dart';
import 'package:super_mall/core/network/api_exceptions.dart';
import 'package:super_mall/core/network/network_info.dart';
import 'package:super_mall/features/auth/forget_password/data/model/forget_password.dart';

abstract class ForgetPasswordRepositoryBase {
  Future<Either<Failure, void>> resetPassword(String email);
}

class ForgetPasswordRepository implements ForgetPasswordRepositoryBase {
  final ApiClient _apiClient;
  final NetworkInfo _networkInfo;

  ForgetPasswordRepository({
    required ApiClient apiClient,
    required NetworkInfo networkInfo,
  })  : _apiClient = apiClient,
        _networkInfo = networkInfo;

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
