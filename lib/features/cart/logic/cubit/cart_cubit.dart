import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../product/data/model/product.dart';
import '../../data/model/cart.dart';
import '../../data/model/cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final _uuid = const Uuid();

  void loadCart() {
    emit(CartLoading());
    try {
      // Here you would typically fetch cart from local storage or API
      // For now we'll just initialize an empty cart
      emit(CartLoaded(cart: Cart()));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void addToCart(Product product, {int quantity = 1}) {
    if (state is CartLoaded) {
      try {
        final currentState = state as CartLoaded;
        final currentCart = currentState.cart;
        final currentItems = currentCart.items;

        // Check if product already exists in cart
        final existingItemIndex = currentItems
            .indexWhere((item) => item.product.code == product.code);

        List<CartItem> updatedItems;

        if (existingItemIndex >= 0) {
          // Update existing item quantity
          final existingItem = currentItems[existingItemIndex];
          final updatedItem =
              existingItem.copyWith(quantity: existingItem.quantity + quantity);

          updatedItems = List<CartItem>.from(currentItems);
          updatedItems[existingItemIndex] = updatedItem;
        } else {
          // Add new item
          final newItem = CartItem(
            id: product.code,
            product: product,
            quantity: quantity,
            price: product.price.toDouble(),
          );

          updatedItems = List<CartItem>.from(currentItems)..add(newItem);
        }

        emit(CartLoaded(cart: Cart(items: updatedItems)));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    }
  }

  void removeFromCart(String itemId) {
    if (state is CartLoaded) {
      try {
        final currentState = state as CartLoaded;
        final currentCart = currentState.cart;
        final updatedItems =
            currentCart.items.where((item) => item.id != itemId).toList();

        emit(CartLoaded(cart: Cart(items: updatedItems)));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    }
  }

  void updateQuantity(Product product, int quantity) {
    if (state is CartLoaded) {
      try {
        final currentState = state as CartLoaded;
        final currentCart = currentState.cart;
        final currentItems = currentCart.items;

        final itemIndex =
            currentItems.indexWhere((item) => item.id == product.code);

        if (itemIndex >= 0) {
          final item = currentItems[itemIndex];
          final updatedItem = item.copyWith(quantity: quantity);

          final updatedItems = List<CartItem>.from(currentItems);

          if (quantity > 0) {
            updatedItems[itemIndex] = updatedItem;
          } else {
            updatedItems.removeAt(itemIndex);
          }

          emit(CartLoaded(cart: Cart(items: updatedItems)));
        }
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    }
  }

  int getQuantity(Product product) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final currentCart = currentState.cart;
      final currentItems = currentCart.items;

      final itemIndex =
          currentItems.indexWhere((item) => item.id == product.code);

      if (itemIndex >= 0) {
        final item = currentItems[itemIndex];
        return item.quantity;
      }
    }
    return 0;
  }

  void clearCart() {
    emit(CartLoaded(cart: Cart()));
  }
}
