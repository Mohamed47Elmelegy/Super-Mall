import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_mall/shared/widget/skeleton_category_item.dart';
import 'package:super_mall/shared/widget/skeleton_product_item.dart';

/// A skeleton placeholder for the home screen
class SkeletonHomeScreen extends StatelessWidget {
  const SkeletonHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              // Search bar
              Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(color: Colors.grey[300]!),
                ),
              ),
              SizedBox(height: 20.h),
              // Categories
              const SkeletonCategoryList(title: 'Categories'),
              SizedBox(height: 20.h),
              // Top Selling
              const SkeletonProductList(title: 'Top Selling'),
              SizedBox(height: 20.h),
              // New In
              const SkeletonProductList(title: 'New In'),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// A skeleton placeholder for the product details screen
class SkeletonProductDetailsScreen extends StatelessWidget {
  const SkeletonProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Container(
              width: double.infinity,
              height: 300.h,
              color: Colors.grey[300],
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name
                  Container(
                    width: 200.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Price
                  Container(
                    width: 100.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Description title
                  Container(
                    width: 120.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Description
                  Container(
                    width: double.infinity,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Add to cart button
                  Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A skeleton placeholder for the profile screen
class SkeletonProfileScreen extends StatelessWidget {
  const SkeletonProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              // Avatar
              CircleAvatar(
                radius: 50.r,
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(height: 20.h),
              // User info card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150.w,
                      height: 20.h,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 7.h),
                    Container(
                      width: 200.w,
                      height: 16.h,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 7.h),
                    Container(
                      width: 120.w,
                      height: 16.h,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              // Menu items
              for (int i = 0; i < 5; i++) ...[
                Container(
                  width: double.infinity,
                  height: 50.h,
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10.w),
                      Container(
                        width: 100.w,
                        height: 16.h,
                        color: Colors.grey[300],
                      ),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
                      SizedBox(width: 10.w),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              // Sign out button
              Container(
                width: 100.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A skeleton placeholder for the categories screen
class SkeletonCategoriesScreen extends StatelessWidget {
  const SkeletonCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Container(
              width: 200.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 20.h),
            // Category items
            Expanded(
              child: ListView.separated(
                itemCount: 8,
                separatorBuilder: (context, index) => SizedBox(height: 7.h),
                itemBuilder: (context, index) => _skeletonCategoryItem(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _skeletonCategoryItem() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          // Category icon
          CircleAvatar(
            radius: 22.5.r,
            backgroundColor: Colors.grey[300],
          ),
          SizedBox(width: 10.w),
          // Category name
          Container(
            width: 150.w,
            height: 15.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}

/// A skeleton placeholder for the category screen (showing products in a grid)
class SkeletonCategoryScreen extends StatelessWidget {
  const SkeletonCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: EdgeInsets.all(16.r),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.r,
          mainAxisSpacing: 16.r,
          childAspectRatio: 0.7,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image
                Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product name
                      Container(
                        width: double.infinity,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      // Product price
                      Container(
                        width: 60.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SkeletonBannerCarousel extends StatelessWidget {
  const SkeletonBannerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15.r),
            ),
          );
        },
      ),
    );
  }
}
