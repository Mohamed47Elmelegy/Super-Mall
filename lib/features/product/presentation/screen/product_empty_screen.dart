import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductEmptyScreen extends StatelessWidget {
  const ProductEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/cart_empty.png',
            width: 100.w,
            height: 100.h,
          ),
          SizedBox(height: 16.h),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 24.h),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: AppColorLight.button,
          //   ),
          //   onPressed: () {
          //     // Navigate to products or home screen
          //     Navigator.of(context).pushReplacementNamed(PageRoutesName.home);
          //   },
          //   child: Text(
          //     'Explore Products',
          //     style: TextStyle(
          //       color: AppColorLight.textButton,
          //       fontSize: 16.sp,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
