import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/routes/page_routes_name.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/cart/logic/cubit/cart_cubit.dart';
import 'package:super_mall/features/cart/logic/cubit/cart_state.dart';
import 'package:super_mall/features/product/data/model/product.dart';
import 'package:super_mall/features/product/logic/cubit/product_cubit.dart';
import 'package:super_mall/features/product/logic/cubit/product_state.dart';
import 'package:super_mall/features/wishlist/logic/wishlist_cubit.dart'
    as wishlist;
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/skeleton_screen.dart';

import '../../../wishlist/logic/wishlist_state.dart' as wishlist;

class ProductScreen extends StatefulWidget {
  final String productCode;
  final Product? product; // Optional, for direct navigation

  const ProductScreen({
    super.key,
    required this.productCode,
    this.product,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    // Skip loading if product is already provided
    if (widget.product == null) {
      context.read<ProductCubit>().getProductById(widget.productCode);
    }
    // Load wishlist
    context.read<wishlist.WishListCubit>().loadWishList();
  }

  @override
  Widget build(BuildContext context) {
    int cartCount = context.watch<CartCubit>().state is CartLoaded
        ? (context.watch<CartCubit>().state as CartLoaded).cart.items.length
        : 0;

    return Scaffold(
      appBar: AppbarBackTitle(
        reverseLeading:
            BlocBuilder<wishlist.WishListCubit, wishlist.WishListState>(
          builder: (context, state) {
            final isFavorite = state is wishlist.WishListLoaded &&
                state.wishListIds
                    .contains(widget.product?.code ?? widget.productCode);
            return Row(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset('assets/vectors/bag-cart.svg'),
                      onPressed: () {
                        Navigator.pushNamed(context, PageRoutesName.cart);
                      },
                    ),
                    if (cartCount > 0)
                      Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$cartCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    final productId =
                        widget.product?.code ?? widget.productCode;
                    context
                        .read<wishlist.WishListCubit>()
                        .toggleWish(productId);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    child: SvgPicture.asset(
                      isFavorite
                          ? 'assets/vectors/fav-filled.svg'
                          : 'assets/vectors/fav-icon.svg',
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        isBackable: true,
      ),
      body: Stack(
        children: [
          widget.product != null
              ? _buildProductDetails(widget.product!)
              : BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const SkeletonProductDetailsScreen();
                    } else if (state is ProductError) {
                      return Center(child: Text(state.message));
                    } else if (state is ProductDetailLoaded) {
                      return _buildProductDetails(state.product);
                    }
                    return const SizedBox();
                  },
                ),
        ],
      ),
      bottomNavigationBar: widget.product != null
          ? _buildBottomBar(widget.product!)
          : BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductDetailLoaded) {
                  return _buildBottomBar(state.product);
                }
                return const SizedBox();
              },
            ),
    );
  }

  Widget _buildProductDetails(Product product) {
    int quantity = context.watch<CartCubit>().getQuantity(product);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Home > ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      '${product.category['en']} > ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Text(
                  product.name['en'] ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.35,
                autoPlay: true,
              ),
              items: product.gallery.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 1.0.w),
                        child: Image.network(i, fit: BoxFit.cover),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10.h),
            Text(product.name['en'] ?? '',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            if (product.isBest) ProductsBadge('Best Seller', Colors.orange),
            if (product.isNew) ProductsBadge('New', Colors.green),
            if (product.isFeatured) ProductsBadge('Featured', Colors.blue),
            if (product.isHot) ProductsBadge('Hot', Colors.red),

            Text('\$ ${product.price}',
                style:
                    TextStyle(fontSize: 18.sp, color: AppColorLight.primary)),
            SizedBox(height: 10.h),
            Text(product.description['en'] ?? '',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600])),
            SizedBox(height: 20.h),
            _buildQuantitySelector(product, quantity),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20.r),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(2.5.r),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.local_shipping_outlined, size: 30.sp),
                              SizedBox(height: 16.h),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                  ),
                                  children: [
                                    TextSpan(text: 'Estimate delivery times: '),
                                    TextSpan(
                                      text: '12-26 days',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: ' (International), '),
                                    TextSpan(
                                      text: '3-6 days',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: ' (United States).'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20.r),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(2.5.r),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.assignment_return_outlined,
                                  size: 30.sp),
                              SizedBox(height: 16.h),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                  ),
                                  children: [
                                    TextSpan(text: 'Return within '),
                                    TextSpan(
                                      text: '30 days',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text:
                                            ' of purchase. Duties & taxes are non-refundable.'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // SizedBox(height: 20.h),
            // Text('4.5 Ratings'),
            // Text(
            //   '213 Reviews',
            //   style: TextStyle(
            //     fontSize: 14.sp,
            //     color: Colors.grey[600],
            //   ),
            // ),
            // _reviewCard(),
            // _reviewCard(),
          ],
        ),
      ),
    );
  }

  Container ProductsBadge(String text, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
            decoration: BoxDecoration(
              border: Border.all(color: color ?? AppColorLight.primary),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: color ?? AppColorLight.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildSizeSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColorLight.grey1,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Text('Size'),
          Spacer(),
          Text(
            'S',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColorLight.grey1,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Text('Color'),
          Spacer(),
          Container(
            width: 15.w,
            height: 15.h,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(Product product, int quantity) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColorLight.grey1,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Text('Quantity'),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorLight.button,
            ),
            child: IconButton(
              onPressed: () {
                onAdd(product, quantity);
              },
              icon: Icon(Icons.add, color: AppColorLight.textButton),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text('$quantity'),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorLight.button,
            ),
            child: IconButton(
              onPressed: () {
                onRemove(product, quantity);
              },
              icon: Icon(Icons.remove, color: AppColorLight.textButton),
            ),
          ),
        ],
      ),
    );
  }

  void addToCartIfNotExists(Product product) {
    final cartCubit = context.read<CartCubit>();
    if (cartCubit.getQuantity(product) == 0) {
      cartCubit.addToCart(product, quantity: 1);
    }
  }

  void onAdd(Product product, int quantity) {
    final cartCubit = context.read<CartCubit>();
    if (quantity == 0) {
      cartCubit.addToCart(product, quantity: 1);
    } else {
      cartCubit.updateQuantity(product, quantity + 1);
    }
  }

  void onRemove(Product product, int quantity) {
    final cartCubit = context.read<CartCubit>();
    if (quantity > 1) {
      cartCubit.updateQuantity(product, quantity - 1);
    } else if (quantity == 1) {
      cartCubit.removeFromCart(product.code);
    }
  }

  Widget _reviewCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.grey[300],
                ),
                SizedBox(width: 10.w),
                Text('Alex Morgan'),
                Spacer(),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < 4 ? Icons.star : Icons.star_half,
                      color: Colors.amber,
                    );
                  }),
                )
              ],
            ),
            SizedBox(height: 10.h),
            Text(
                'opinionsopinionsopinionsopinionsopinionsopinionsopinionsopinionsopinionsopinionsopinionsopinionsopinionsopinionsopinionsopinions'),
            Text('12days ago'),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(Product product) {
    int quantity = context.watch<CartCubit>().getQuantity(product);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: GestureDetector(
        onTap: () {
          addToCartIfNotExists(product);
          // Show snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${product.name['en']} added to cart'),
              action: SnackBarAction(
                label: 'VIEW CART',
                onPressed: () {
                  Navigator.pushNamed(context, PageRoutesName.cart);
                },
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
          decoration: BoxDecoration(
            color: AppColorLight.button, // Light beige
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${(product.price * (quantity == 0 ? 1 : quantity)).toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColorLight.textButton,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Add to cart',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColorLight.textButton,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
