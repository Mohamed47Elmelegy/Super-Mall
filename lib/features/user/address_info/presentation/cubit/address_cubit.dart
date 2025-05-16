import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/address_model.dart';
import '../../data/repositories/address_repository.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepository _repository;

  AddressCubit(this._repository) : super(AddressInitial());

  Future<void> getAddresses() async {
    emit(AddressLoading());
    final result = await _repository.getAddresses();
    result.fold(
      (failure) => emit(AddressError(failure.message)),
      (addresses) => emit(AddressLoadedSucess(addresses)),
    );
  }

  Future<void> createAddress(AddressModel address) async {
    emit(AddressLoading());
    final result = await _repository.createAddress(address);
    result.fold(
      (failure) => emit(AddressError(failure.message)),
      (_) => getAddresses(),
    );
  }

  Future<void> updateAddress(AddressModel address) async {
    emit(AddressLoading());
    final result = await _repository.updateAddress(address);
    result.fold(
      (failure) => emit(AddressError(failure.message)),
      (_) => getAddresses(),
    );
  }

  Future<void> deleteAddress(int addressId) async {
    emit(AddressLoading());
    final result = await _repository.deleteAddress(addressId);
    result.fold(
      (failure) => emit(AddressError(failure.message)),
      (_) => getAddresses(),
    );
  }
}
