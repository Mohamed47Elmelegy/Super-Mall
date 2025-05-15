import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_item_state.dart';
import 'cart_cubit.dart';
import 'cart_state.dart';

class CartItemCubit extends Cubit<CartItemState> {
  final CartCubit cartCubit;
  final String itemId;

  CartItemCubit({
    required this.cartCubit,
    required this.itemId,
  }) : super(CartItemInitial()) {
    _loadCartItem();
  }

  void _loadCartItem() {
    emit(CartItemLoading());
    try {
      if (cartCubit.state is CartLoaded) {
        final cartState = cartCubit.state as CartLoaded;
        final item = cartState.cart.items.firstWhere(
          (item) => item.id == itemId,
          orElse: () => throw Exception('Cart item not found'),
        );
        emit(CartItemLoaded(item: item));
      } else {
        emit(CartItemError(message: 'Cart not loaded'));
      }
    } catch (e) {
      emit(CartItemError(message: e.toString()));
    }
  }

  void increaseQuantity() {
    if (state is CartItemLoaded) {
      final currentState = state as CartItemLoaded;
      final currentItem = currentState.item;
      cartCubit.updateQuantity(currentItem.product, currentItem.quantity + 1);
      _loadCartItem();
    }
  }

  void decreaseQuantity() {
    if (state is CartItemLoaded) {
      final currentState = state as CartItemLoaded;
      final currentItem = currentState.item;
      if (currentItem.quantity > 1) {
        cartCubit.updateQuantity(currentItem.product, currentItem.quantity - 1);
        _loadCartItem();
      } else {
        removeItem();
      }
    }
  }

  void updateQuantity(int quantity) {
    if (state is CartItemLoaded) {
      final currentItem = (state as CartItemLoaded).item;
      cartCubit.updateQuantity(currentItem.product, quantity);
      _loadCartItem();
    }
  }

  void removeItem() {
    cartCubit.removeFromCart(itemId);
    emit(CartItemInitial());
  }
}
