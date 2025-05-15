import '../../data/model/cart.dart';
import '../../data/model/cart_item.dart';

sealed class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Cart cart;

  CartLoaded({required this.cart});
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}
