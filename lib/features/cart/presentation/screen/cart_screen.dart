import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/theme/app_color/app_color_light.dart';
import '../../data/model/cart.dart';
import '../../logic/cubit/cart_cubit.dart';
import '../../logic/cubit/cart_state.dart';
import '../widgets/cart_empty.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cart_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLoaded && state.cart.items.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    context.read<CartCubit>().clearCart();
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartInitial) {
            context.read<CartCubit>().loadCart();
            return  Center(child: SpinKitWaveSpinner(
                      size: 120,
                      trackColor: Colors.green[100]!,
                      waveColor: Colors.green[300]!,
                      color: AppColorLight.primary));
          } else if (state is CartLoading) {
            return Center(child: SpinKitWaveSpinner(
                      size: 120,
                      trackColor: Colors.green[100]!,
                      waveColor: Colors.green[300]!,
                      color: AppColorLight.primary));
          } else if (state is CartLoaded) {
            if (state.cart.items.isEmpty) {
              return const CartEmpty();
            }
            return _buildCartContent(context, state.cart);
          } else if (state is CartError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: AppColorLight.red),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, Cart cart) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16.r),
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 16.r),
                child: CartItemCard(item: item),
              );
            },
          ),
        ),
        CartSummary(cart: cart),
      ],
    );
  }
}
