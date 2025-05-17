import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routes/page_routes_name.dart';
import '../../../../core/theme/app_color/app_color_light.dart';
import '../../../../shared/widget/empty_pages.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyPages(
      imageType: 'asset',
      image: 'assets/images/cart_empty.png',
      title: 'Your Cart is Empty',
      description: 'Browse products and add items to your cart',
      buttonText: 'Explore Products',
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(PageRoutesName.home);
      },
    );
  }
}
