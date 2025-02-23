import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/user/payment_info/presentation/screen/add_card_screen.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/button_primary.dart';

class PaymentInfoScreen extends StatelessWidget {
  const PaymentInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        title: 'Payment',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          children: [
            SizedBox(height: 15.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Cards',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            _buildCardDetails('**** 1234',
                image: 'assets/images/mastercard.png'),
            SizedBox(height: 15.h),
            _buildCardDetails('**** 1234',
                image: 'assets/images/mastercard.png'),
            SizedBox(height: 15.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Paypal',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            _buildPaypalDetails('ab360180@gmail.com'),
            Spacer(),
            ButtonPrimary(
                title: 'Add Card',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddCardScreen();
                  }));
                }),
          ],
        ),
      ),
    );
  }

  Container _buildCardDetails(String text, {required String image}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColorLight.grey1,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 10.w),
          Text(text),
          SizedBox(width: 10.w),
          Image.asset(image),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }

  Container _buildPaypalDetails(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColorLight.grey1,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 10.w),
          Text(text),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }
}
