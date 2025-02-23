import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/checkout/presentation/screen/successfully_checkout.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/button_primary.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        title: 'Checkout',
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0.r),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  CheckoutPart(
                    title: 'Shipping Address',
                    value: 'Add Shipping Address',
                  ),
                  SizedBox(height: 20.h),
                  CheckoutPart(
                    title: 'Payment Method',
                    value: 'Add Payment Method',
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  _buildCalculationSliver('Subtotal', 100.0),
                  _buildCalculationSliver('Shipping Cost', 50.0),
                  _buildCalculationSliver('Tax', 0),
                  _buildCalculationSliver('Total', 1550),
                ],
              ),
            ),
            ButtonPrimary(
              title: 'Checkout',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SuccessfullyCheckout()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildCalculationSliver(String title, double price) {
    return Padding(
      padding: EdgeInsets.all(5.r),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Spacer(),
          Text('EGP$price'),
        ],
      ),
    );
  }
}

class CheckoutPart extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onPressed;

  const CheckoutPart({
    required this.title,
    required this.value,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColorLight.grey1,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xff272727),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
