import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonCategoryItem extends StatelessWidget {
  const SkeletonCategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Column(
          children: [
            ClipOval(
              child: Container(
                width: MediaQuery.of(context).size.width / 5.w,
                height: MediaQuery.of(context).size.width / 5.w,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              'Category Name',
              style: TextStyle(fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}

class SkeletonCategoryList extends StatelessWidget {
  final String title;
  final int itemCount;

  const SkeletonCategoryList({
    super.key,
    required this.title,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (context, index) => const SkeletonCategoryItem(),
          ),
        ),
      ],
    );
  }
}
