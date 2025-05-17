import 'package:equatable/equatable.dart';
import '../../../cart/data/model/cart_item.dart';
import '../../../user/address_info/data/models/address_model.dart';

abstract class CheckoutState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutAddressSelected extends CheckoutState {
  final AddressModel address;
  CheckoutAddressSelected(this.address);

  @override
  List<Object?> get props => [address];
}

class CheckoutCartUpdated extends CheckoutState {
  final List<CartItem> items;
  final double total;
  CheckoutCartUpdated(this.items, this.total);

  @override
  List<Object?> get props => [items, total];
}

class CheckoutConfirmed extends CheckoutState {
  final AddressModel address;
  final List<CartItem> items;
  final double total;
  CheckoutConfirmed(this.address, this.items, this.total);

  @override
  List<Object?> get props => [address, items, total];
}

class CheckoutError extends CheckoutState {
  final String message;
  CheckoutError(this.message);

  @override
  List<Object?> get props => [message];
}

class Checkout {}
