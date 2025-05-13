import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/user/wishlist/presentation/screen/wishlist_list_screen.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/item.dart';
import 'package:super_mall/features/product/data/model/product.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // مثال على منتجات وهمية، استبدلها بمنتجات حقيقية من الـ API أو من مزود الحالة
  final List<Product> products = [
    Product(
      code: '1',
      name: {'en': 'Nike Fuel Pack'},
      category: {'en': 'Bags'},
      brand: {'en': 'Nike'},
      description: {'en': 'A great pack for your fuel.'},
      image: 'https://via.placeholder.com/150',
      gallery: ['https://via.placeholder.com/150'],
      quantity: 10,
      price: 400,
      isActive: true,
      isNew: false,
      isFeatured: false,
      isBest: false,
      isHot: false,
      createdAt: '2024-01-01',
    ),
    Product(
      code: '2',
      name: {'en': 'Nike Show X Rush'},
      category: {'en': 'Shoes'},
      brand: {'en': 'Nike'},
      description: {'en': 'Show X Rush shoes.'},
      image: 'https://via.placeholder.com/150',
      gallery: ['https://via.placeholder.com/150'],
      quantity: 5,
      price: 900,
      isActive: true,
      isNew: false,
      isFeatured: false,
      isBest: false,
      isHot: false,
      createdAt: '2024-01-01',
    ),
    // أضف المزيد من المنتجات حسب الحاجة
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
              description: '${products.length} Products',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WishlistListScreen(
                    items: products.map((product) => Item(product: product)).toList(),
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
