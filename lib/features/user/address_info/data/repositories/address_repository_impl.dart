import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/error/failures.dart';
import '../models/address_model.dart';
import 'address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final Dio dio;

  AddressRepositoryImpl({required this.dio});

  @override
  Future<Either<Failure, List<AddressModel>>> getAddresses() async {
    try {
      final response = await dio.get('/addresses');
      log('API status: ${response.statusCode}, data: ${response.data}');
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final addresses =
            jsonList.map((json) => AddressModel.fromJson(json)).toList();
        return Right(addresses);
      } else {
        log('API error: ${response.statusCode} ${response.data}');
        return Left(ServerFailure(
          message: 'Failed to fetch addresses',
          statusCode: response.statusCode,
        ));
      }
    } on DioException catch (e) {
      log('DioException: ${e.message}, response: ${e.response}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to fetch addresses',
        statusCode: e.response?.statusCode,
      ));
    } catch (e) {
      log('Other error: $e');
      return Left(NetworkFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddressModel>> createAddress(
      AddressModel address) async {
    try {
      final response = await dio.post(
        '/addresses',
        data: address.toJson(),
      );

      if (response.statusCode == 201) {
        return Right(AddressModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(
          message: 'Failed to create address',
          statusCode: response.statusCode,
        ));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to create address',
        statusCode: e.response?.statusCode,
      ));
    } catch (e) {
      return Left(NetworkFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddressModel>> updateAddress(
      AddressModel address) async {
    try {
      final response = await dio.put(
        '/addresses/${address.id}',
        data: address.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(AddressModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(
          message: 'Failed to update address',
          statusCode: response.statusCode,
        ));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to update address',
        statusCode: e.response?.statusCode,
      ));
    } catch (e) {
      return Left(NetworkFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAddress(int addressId) async {
    try {
      final response = await dio.delete('/addresses/$addressId');

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(ServerFailure(
          message: 'Failed to delete address',
          statusCode: response.statusCode,
        ));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(
        message: e.message ?? 'Failed to delete address',
        statusCode: e.response?.statusCode,
      ));
    } catch (e) {
      return Left(NetworkFailure(message: e.toString()));
    }
  }
}
