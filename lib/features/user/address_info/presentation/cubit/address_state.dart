import 'package:equatable/equatable.dart';
import '../../data/models/address_model.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object?> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoadedSucess extends AddressState {
  final List<AddressModel> addresses;

  const AddressLoadedSucess(this.addresses);

  @override
  List<Object?> get props => [addresses];
}

class AddressError extends AddressState {
  final String message;

  const AddressError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddressCreated extends AddressState {
  final AddressModel address;

  const AddressCreated(this.address);

  @override
  List<Object?> get props => [address];
}

class AddressUpdated extends AddressState {
  final AddressModel address;

  const AddressUpdated(this.address);

  @override
  List<Object?> get props => [address];
}

class AddressDeleted extends AddressState {
  final int addressId;

  const AddressDeleted(this.addressId);

  @override
  List<Object?> get props => [addressId];
}
