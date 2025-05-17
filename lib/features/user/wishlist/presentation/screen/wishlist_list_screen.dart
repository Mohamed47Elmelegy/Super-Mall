import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/animated_product_list.dart';
import 'package:super_mall/features/product/data/model/product.dart';

class WishlistListScreen extends StatelessWidget {
  final String title;
  final List<Product> products;

  const WishlistListScreen({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        title: title,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: products.isEmpty
            ? Center(
                child: Text(
                  'No favorite products yet',
                  style: TextStyle(fontSize: 16.sp),
                ),
              )
            : AnimatedProductList(
                products: products,
                childAspectRatio: 0.6,
                crossAxisCount: 2,
                spacing: 5,
                padding: EdgeInsets.zero,
              ),
      ),
    );
  }
}
