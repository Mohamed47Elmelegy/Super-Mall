import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/product/logic/cubit/product_cubit.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/skeleton_screen.dart';
import '../../data/model/product.dart';
import '../../logic/cubit/product_state.dart';

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
  @override
  void initState() {
    super.initState();
    // Skip loading if product is already provided
    if (widget.product == null) {
      context.read<ProductCubit>().getProductById(widget.productCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(
        reverseLeading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/vectors/fav-icon.svg'),
        ),
        isBackable: true,
      ),
      body: widget.product != null
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
    );
  }

  Widget _buildProductDetails(Product product) {
    final List<String> images =
        product.gallery.isNotEmpty ? product.gallery : [product.image];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.35,
                autoPlay: true,
              ),
              items: images.map((i) {
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
            SizedBox(height: 20.h),
            Text(product.name['en'] ?? '',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            Text('EGP ${product.price}',
                style:
                    TextStyle(fontSize: 18.sp, color: AppColorLight.primary)),
            SizedBox(height: 10.h),
            Text('Brand: ${product.brand['en'] ?? ''}'),
            Text('Category: ${product.category['en'] ?? ''}'),
            Text('Quantity: ${product.quantity}'),
            SizedBox(height: 20.h),
            Text(product.description['en'] ?? '',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600])),
            SizedBox(height: 20.h),
            Text('Shipping & Returns'),
            SizedBox(height: 10.h),
            Text('Free standard shipping and free 60-day returns',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600])),
            SizedBox(height: 20.h),
            _buildSizeSelector(),
            SizedBox(height: 10.h),
            _buildColorSelector(),
            SizedBox(height: 10.h),
            _buildQuantitySelector(),
            SizedBox(height: 10.h),
            Text(
              'Built for life and made to last, this full-zip corduroy jacket is part of our Nike Life collection. The spacious fit gives you plenty of room to layer underneath, while the soft corduroy keeps it casual and timeless.',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20.h),
            Text('4.5 Ratings'),
            Text(
              '213 Reviews',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            _reviewCard(),
            _reviewCard(),
          ],
        ),
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

  Widget _buildQuantitySelector() {
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
              color: AppColorLight.primary,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text('1'),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorLight.primary,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
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
}
