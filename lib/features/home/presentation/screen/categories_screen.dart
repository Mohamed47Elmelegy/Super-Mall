import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  double screenPadding = 20.w;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shop by Categories',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),
            _categoryItem('Mobile', 'assets/images/mobile_cat.png'),
            SizedBox(height: 7.h),
            _categoryItem('Cosmetics', 'assets/images/cosmetics_cat.png'),
            SizedBox(height: 7.h),
            _categoryItem('Furniture', 'assets/images/furniture_cat.png'),
            SizedBox(height: 7.h),
            _categoryItem('Watches', 'assets/images/watch_cat.png'),
            SizedBox(height: 7.h),
            _categoryItem('Fashion', 'assets/images/fashion_cat.png'),
          ],
        ),
      ),
    );
  }

  Container _categoryItem(String title, String path) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColorLight.grey1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              path,
              height: 45.h,
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
