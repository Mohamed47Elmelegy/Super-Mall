import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../models/address_model.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<AddressModel>>> getAddresses();
  Future<Either<Failure, AddressModel>> createAddress(AddressModel address);
  Future<Either<Failure, AddressModel>> updateAddress(AddressModel address);
  Future<Either<Failure, bool>> deleteAddress(int addressId);
}
