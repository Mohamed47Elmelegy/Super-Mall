import 'cart_item.dart';

class Cart {
  final List<CartItem> items;

  Cart({
    this.items = const [],
  });

  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + item.total);
  }

  int get itemCount {
    return items.length;
  }

  Cart copyWith({
    List<CartItem>? items,
  }) {
    return Cart(
      items: items ?? this.items,
    );
  }
}
