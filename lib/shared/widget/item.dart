import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/product/data/model/product.dart';
import 'package:super_mall/core/routes/page_routes_name.dart';

import '../../features/cart/logic/cubit/cart_cubit.dart';

class Item extends StatelessWidget {
  final Product product;

  const Item({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          PageRoutesName.productDetails,
          arguments: product,
        );
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(5.r),
          constraints: BoxConstraints(
            minHeight: 220.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColorLight.grey1,
          ),
          child: SizedBox(
            width: 150.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      child: Image.network(
                        product.gallery.isNotEmpty
                            ? product.gallery.first
                            : product.image,
                        width: 150.w,
                        height: 150.h,
                        fit: BoxFit.fitHeight,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.broken_image, size: 150.w),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: SvgPicture.asset(
                        'assets/vectors/fav-icon.svg',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  product.name['en'] ?? '',
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('EGP ${product.price}'),
                    IconButton(
                      color: AppColorLight.primary,
                      icon: SvgPicture.asset('assets/vectors/bag.svg'),
                      onPressed: () {
                        context.read<CartCubit>().addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Product added to cart'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
