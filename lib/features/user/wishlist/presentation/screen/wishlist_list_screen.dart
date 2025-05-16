import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/gridview_primary.dart';
import 'package:super_mall/shared/widget/item.dart';
import 'package:super_mall/features/product/data/model/product.dart';
import 'package:super_mall/features/wishlist/logic/wishlist_cubit.dart';
import 'package:super_mall/features/product/logic/cubit/product_cubit.dart';
import 'package:super_mall/features/product/logic/cubit/product_state.dart';

import '../../../../wishlist/logic/wishlist_state.dart';

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
            : SingleChildScrollView(
                child: GridViewPrimary(
                  items: products
                      .map((product) => Item(product: product))
                      .toList(),
                  childAspectRatio: 0.6,
                ),
              ),
      ),
    );
  }
}
