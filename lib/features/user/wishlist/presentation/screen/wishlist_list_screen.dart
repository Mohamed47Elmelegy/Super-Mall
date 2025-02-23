import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/gridview_primary.dart';
import 'package:super_mall/shared/widget/item.dart';

class WishlistListScreen extends StatelessWidget {
  final String title;
  final List<Item> items;

  const WishlistListScreen({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        title: title,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: SingleChildScrollView(
            child: GridViewPrimary(items: items, childAspectRatio: 0.6)),
      ),
    );
  }
}
