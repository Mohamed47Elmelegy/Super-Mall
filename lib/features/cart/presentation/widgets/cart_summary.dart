import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/page_routes_name.dart';
import '../../../../core/theme/app_color/app_color_light.dart';
import '../../data/model/cart.dart';

class CartSummary extends StatelessWidget {
  final Cart cart;

  const CartSummary({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double subtotal = cart.totalAmount;
    final double shipping = 10.0; // Example shipping cost
    final double total = subtotal + shipping;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          _buildSummaryRow('Shipping', '\$${shipping.toStringAsFixed(2)}'),
          SizedBox(height: 8.h),
          Divider(height: 16.h, thickness: 1),
          _buildSummaryRow(
            'Total',
            '\$${total.toStringAsFixed(2)}',
            isBold: true,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, PageRoutesName.checkout);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColorLight.button,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Proceed to Checkout',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColorLight.textButton,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 16.sp : 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 16.sp : 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
