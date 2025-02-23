import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/shared/widget/item.dart';

class GridViewPrimary extends StatelessWidget {
  final List<Item> items;
  final double childAspectRatio;

  const GridViewPrimary({
    super.key,
    required this.items,
    required this.childAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: 5.w,
          mainAxisSpacing: 5.h),
      children: [...items],
    );
  }
}
