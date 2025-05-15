import '../../data/model/cart_item.dart';

sealed class CartItemState {}

class CartItemInitial extends CartItemState {}

class CartItemLoading extends CartItemState {}

class CartItemLoaded extends CartItemState {
  final CartItem item;

  CartItemLoaded({required this.item});
}

class CartItemError extends CartItemState {
  final String message;

  CartItemError({required this.message});
}
