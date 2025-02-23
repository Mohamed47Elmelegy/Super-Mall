import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/product/presentation/screen/product_screen.dart';

class Item extends StatelessWidget {
  final String path;
  final String title;
  final double price;

  const Item({
    super.key,
    required this.path,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProductScreen()));
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      child: Image.asset(
                        width: 150.w,
                        path,
                        fit: BoxFit.fitHeight,
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
                  title,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3.h),
                Text('EGP $price'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
