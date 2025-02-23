import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/user/wishlist/presentation/screen/wishlist_list_screen.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/item.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final i = [
    Item(
        path: 'assets/images/myfavorites_1.png',
        price: 400,
        title: 'Nike Fuel Pack'),
    Item(
        path: 'assets/images/myfavorites_2.png',
        price: 900,
        title: 'Nike Show X Rush'),
    Item(
        path: 'assets/images/myfavorites_3.png',
        price: 200,
        title: 'Men\'s T-Shirt'),
    Item(
        path: 'assets/images/myfavorites_4.png',
        price: 250,
        title: 'Men\'s Skate T-Shirt'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        title: 'Wishlist',
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            FavoriteListToGo(
              title: 'My Favorites',
              description: '12 Products',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WishlistListScreen(
                    items: i,
                    title: 'My Favorites',
                  );
                }));
              },
            ),
            SizedBox(height: 10.h),
            FavoriteListToGo(
              title: 'T-Shirts',
              description: '4 Products',
            ),
          ],
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
              SizedBox(
                height: 5.h,
              ),
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
