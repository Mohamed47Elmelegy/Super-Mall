import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/user/wishlist/presentation/screen/wishlist_list_screen.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/features/wishlist/logic/wishlist_cubit.dart';
import 'package:super_mall/features/product/data/model/product.dart';
import 'package:super_mall/features/product/logic/cubit/product_cubit.dart';
import 'package:super_mall/features/product/logic/cubit/product_state.dart';
import 'dart:developer';
import '../../../../wishlist/logic/wishlist_state.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    // تحميل المنتجات عند فتح الشاشة
    context.read<ProductCubit>().getProducts();
    // تحميل المفضلة
    context.read<WishListCubit>().loadWishList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        title: 'Wishlist',
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: BlocBuilder<WishListCubit, WishListState>(
          builder: (context, wishState) {
            // جلب المنتجات الحقيقية من ProductCubit
            final products = context.select<ProductCubit, List<Product>>(
              (cubit) => cubit.state is ProductLoaded
                  ? (cubit.state as ProductLoaded).products
                  : [],
            );

            // تصفية المنتجات المفضلة باستخدام الـ code مباشرة
            final wishProducts = products
                .where((p) => wishState.wishListIds.contains(p.code))
                .toList();

            log('Wishlist products: ${wishProducts.length}');
            log('Wishlist IDs: ${wishState.wishListIds}');
            log('All products: ${products.length}');

            return Column(
              children: [
                FavoriteListToGo(
                  title: 'My Favorites',
                  description: '${wishProducts.length} Products',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishlistListScreen(
                          title: 'My Favorites',
                          products: wishProducts,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.h),
                FavoriteListToGo(
                  title: 'T-Shirts',
                  description: '4 Products',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class FavoriteListToGo extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onPressed;

  const FavoriteListToGo({
    super.key,
    required this.title,
    required this.description,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColorLight.grey1,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/vectors/fav-icon.svg',
            height: 30.h,
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              SizedBox(height: 5.h),
              Text(description),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
