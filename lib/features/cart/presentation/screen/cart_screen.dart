import 'package:flutter/material.dart';
import 'package:super_mall/features/cart/presentation/view/cart_item.dart';
import 'package:super_mall/features/cart/presentation/view/empty_cart.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(),
      body: !isEmpty ? EmptyCart() : CartItem(),
    );
  }
}
