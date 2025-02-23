import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        title: 'Order #456765',
      ),
      body: Column(
        children: [
          SizedBox(height: 40.h),
          _orderStatus(context, 'Deliverd', true),
          SizedBox(height: 40.h),
          _orderStatus(context, 'Shipped', false),
          SizedBox(height: 40.h),
          _orderStatus(context, 'Order Confirmed', false),
          SizedBox(height: 40.h),
          _orderStatus(context, 'Order Placed', false),
          SizedBox(height: 40.h),
          _title('Order Items'),
          _orderDetails(),
          SizedBox(height: 20.h),
          _title('Shipping details'),
          _otherDetails()
        ],
      ),
    );
  }

  Padding _otherDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
        decoration: BoxDecoration(
          color: AppColorLight.grey1,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('2715 Ash Dr. Farid Nada, South Banha 83475'),
            Text('121-224-7890'),
          ],
        ),
      ),
    );
  }

  Padding _orderDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
        decoration: BoxDecoration(
          color: AppColorLight.grey1,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset('assets/vectors/orders.svg',
                height: 40.h, width: 40.w),
            SizedBox(width: 10.w),
            Text(
              '4 Items',
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            Spacer(),
            Text(
              'View All',
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _title(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  Padding _orderStatus(BuildContext context, String status, bool isDone) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(children: [
        Container(
          height: 30.h,
          width: 30.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
          child: Icon(
            Icons.done,
            size: 15.sp,
            color: isDone ? Colors.black : Colors.white,
          ),
        ),
        SizedBox(width: 10.w),
        Text(status,
            style: TextStyle(
              color: isDone ? Colors.grey : Colors.black,
              fontSize: 16.sp,
            )),
        Spacer(),
        Text(
          '28 May',
          style: TextStyle(
            color: isDone ? Colors.grey : Colors.black,
          ),
        ),
      ]),
    );
  }
}
