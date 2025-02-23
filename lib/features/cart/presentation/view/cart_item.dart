import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/checkout/presentation/screen/checkout_screen.dart';
import 'package:super_mall/shared/widget/button_primary.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text('Remove All',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp)),
          ),
          SizedBox(height: 10.h),
          ItemCartable(
            imagePath: 'assets/images/example1.png',
            title: 'Men\'s Harrington Jacket',
            size: 'M',
            price: 100.0,
            quantity: 1,
            color: 'Lemon',
          ),
          ItemCartable(
            imagePath: 'assets/images/example2.png',
            title: 'Men\'s Coaches Jacket',
            size: 'M',
            price: 100.0,
            quantity: 1,
            color: 'Navy',
          ),
          SizedBox(height: 200.h),
          _buildCalculationSliver('Subtotal', 100.0),
          _buildCalculationSliver('Shipping Cost', 50.0),
          _buildCalculationSliver('Tax', 0),
          _buildCalculationSliver('Total', 1550),
          Spacer(),
          ButtonPrimary(
            title: 'Checkout',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CheckoutScreen()));
            },
          )
        ],
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

class ItemCartable extends StatelessWidget {
  final String imagePath;
  final String title;
  final String size;
  final double price;
  final int quantity;
  final String color;

  const ItemCartable({
    super.key,
    required this.imagePath,
    required this.title,
    required this.size,
    required this.price,
    required this.quantity,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(5.r),
        child: Container(
          decoration: BoxDecoration(
            color: AppColorLight.grey1,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.all(10.r),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    imagePath,
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 13.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text('Size - $size',
                                style: TextStyle(fontSize: 10.5.sp))),
                        Expanded(
                          child: Text('Color - $color',
                              style: TextStyle(fontSize: 10.5.sp)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'EGP$price',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Container(
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: AppColorLight.primary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.add),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: AppColorLight.primary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.remove),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
