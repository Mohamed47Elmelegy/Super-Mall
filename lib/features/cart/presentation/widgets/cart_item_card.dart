import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color/app_color_light.dart';
import '../../data/model/cart_item.dart';
import '../../logic/cubit/cart_cubit.dart';
import '../../logic/cubit/cart_item_cubit.dart';
import '../../logic/cubit/cart_item_state.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartItemCubit(
        cartCubit: context.read<CartCubit>(),
        itemId: item.id,
      ),
      child: BlocBuilder<CartItemCubit, CartItemState>(
        builder: (context, state) {
          if (state is CartItemLoaded) {
            final cartItem = state.item;
            return _buildCard(context, cartItem);
          } else if (state is CartItemLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartItemError) {
            return Text('Error: ${state.message}');
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, CartItem cartItem) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
            ),
            child: Image.network(
              cartItem.product.image,
              width: 100.w,
              height: 100.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100.w,
                  height: 100.w,
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                    size: 40.r,
                  ),
                );
              },
            ),
          ),
          // Product Details
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Price
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.product.name['en'] ?? 'Product',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '\$${cartItem.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Total: \$${cartItem.total.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Delete Button
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: AppColorLight.red,
                        ),
                        onPressed: () {
                          context.read<CartItemCubit>().removeItem();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // Quantity Control
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildQuantityButton(
                        context,
                        Icons.remove,
                        () => context.read<CartItemCubit>().decreaseQuantity(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          cartItem.quantity.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      _buildQuantityButton(
                        context,
                        Icons.add,
                        () => context.read<CartItemCubit>().increaseQuantity(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorLight.primary,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4.r),
        child: Padding(
          padding: EdgeInsets.all(4.r),
          child: Icon(
            icon,
            size: 16.r,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
