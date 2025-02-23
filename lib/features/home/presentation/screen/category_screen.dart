import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/gridview_primary.dart';
import 'package:super_mall/shared/widget/item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final items = [
    Item(path: 'assets/images/grid_example1.png', title: 'Title', price: 100),
    Item(path: 'assets/images/grid_example2.png', title: 'Title', price: 100),
    Item(path: 'assets/images/grid_example3.png', title: 'Title', price: 100),
    Item(path: 'assets/images/grid_example4.png', title: 'Title', price: 100),
    Item(path: 'assets/images/grid_example5.png', title: 'Title', price: 100),
    Item(path: 'assets/images/grid_example6.png', title: 'Title', price: 100),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Text('Fashion (240)', style: TextStyle(fontSize: 20.sp)),
              SizedBox(height: 20.h),
              SingleChildScrollView(
                child: GridViewPrimary(
                  items: items,
                  childAspectRatio: 0.7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
