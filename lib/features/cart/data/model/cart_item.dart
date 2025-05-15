import '../../../product/data/model/product.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
  });

  double get total => price * quantity;

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    double? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
