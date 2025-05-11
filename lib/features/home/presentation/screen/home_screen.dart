import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/home/presentation/cubit/home_cubit.dart';
import 'package:super_mall/features/home/presentation/screen/categories_screen.dart';
import 'package:super_mall/features/home/presentation/screen/category_screen.dart';
import 'package:super_mall/features/home/presentation/widget/home_appbar.dart';
import 'package:super_mall/shared/widget/bottomnavigationbar_primary.dart';
import 'package:super_mall/shared/widget/gridview_primary.dart';
import 'package:super_mall/shared/widget/item.dart';

import '../cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screenPadding = 20.w;
  TextEditingController searchController = TextEditingController();
  bool isStatic = true;
  List<Item> items = [
    Item(
      path: 'assets/images/search_result1.png',
      price: 800,
      title: 'Club Fleece Mens Jacket',
    ),
    Item(
      path: 'assets/images/search_result2.png',
      price: 800,
      title: 'Skate Jacket',
    ),
    Item(
      path: 'assets/images/search_result3.png',
      price: 800,
      title: 'Therma Fit Puffer Jacket',
    ),
    Item(
      path: 'assets/images/search_result4.png',
      price: 800,
      title: 'Men\'s Workwear Jacket',
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (context.read<HomeCubit>().state is! HomeLoaded) {
      context.read<HomeCubit>().getHomeData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBarPrimary(
            currentIndex: 0,
            onTap: (p0) {},
          ),
          appBar: HomeAppbar(),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _searchField(),
                  if (state is HomeLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (state is HomeError)
                    Center(child: Text(state.message))
                  else if (state is HomeLoaded)
                    _buildDefaultContent(context)
                  else
                    _buildDefaultContent(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _filterItem(
                    text: 3.toString(), icon: Icon(Icons.filter_alt_sharp)),
                SizedBox(width: 3.w),
                _filterItem(
                    text: 'Deals',
                    icon: Icon(Icons.keyboard_arrow_down_rounded)),
                SizedBox(width: 3.w),
                _filterItem(
                    text: 'Price',
                    icon: Icon(Icons.keyboard_arrow_down_rounded)),
                SizedBox(width: 3.w),
                _filterItem(
                    text: 'Sort by',
                    icon: Icon(Icons.keyboard_arrow_down_rounded)),
                SizedBox(width: 3.w),
                _filterItem(
                    text: 'Gender',
                    icon: Icon(Icons.keyboard_arrow_down_rounded)),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Align(
              alignment: Alignment.centerLeft, child: Text('53 Results Found')),
          SizedBox(height: 15.h),
          GridViewPrimary(items: items, childAspectRatio: 0.65),
        ],
      ),
    );
  }

  Widget _filterItem({String? text, required Widget icon}) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: (MediaQuery.of(context).size.height / 2),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Clear'),
                        Text(
                          'Sort by',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    _buildFilterCriteriaItem(
                        title: 'Recommended', context, isActive: true),
                    SizedBox(height: 10.h),
                    _buildFilterCriteriaItem(title: 'Newest', context),
                    SizedBox(height: 10.h),
                    _buildFilterCriteriaItem(
                        title: 'Lowest - Heighest Price', context),
                    SizedBox(height: 10.h),
                    _buildFilterCriteriaItem(
                        title: 'Heighest - Lowest Price', context),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: AppColorLight.grey1,
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Row(
          children: [
            if (text != null) Text(text),
            icon,
          ],
        ),
      ),
    );
  }

  Container _buildFilterCriteriaItem(BuildContext context,
      {required String title, bool isActive = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : AppColorLight.grey1,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
          Spacer(),
          if (isActive) Icon(Icons.check)
        ],
      ),
    );
  }

  Widget _buildDefaultContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        _itemsHeader('Categories', 'See All', action: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CategoriesScreen()));
        }),
        SizedBox(height: 20.h),
        _categoriesElements(),
        SizedBox(height: 20.h),
        _itemsHeader('Top Selling', 'See All', action: () {}),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Item(
                  path: 'assets/images/example1.png',
                  title: 'Men\'s Harrington Jacket',
                  price: 750),
              SizedBox(width: 10.w),
              Item(
                  path: 'assets/images/example2.png',
                  title: 'Max Cirro Men\'s Slides',
                  price: 850),
              SizedBox(width: 10.w),
              Item(
                  path: 'assets/images/example3.png',
                  title: 'Men\'s Harrington Jacket',
                  price: 750),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        _itemsHeader('New In', 'See All', action: () {}),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Item(
                  path: 'assets/images/example4.png',
                  title: 'Men\'s Harrington Jacket',
                  price: 750),
              SizedBox(width: 10.w),
              Item(
                  path: 'assets/images/example5.png',
                  title: 'Men\'s Harrington Jacket',
                  price: 750),
              SizedBox(width: 10.w),
              Item(
                  path: 'assets/images/example6.png',
                  title: 'Men\'s Harrington Jacket',
                  price: 750),
            ],
          ),
        ),
      ],
    );
  }

  Row _itemsHeader(
    String title,
    String title2, {
    required VoidCallback action,
  }) {
    double fontSize = 16.sp;
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: action,
          child: Text(
            title2,
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView _categoriesElements() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _categoryElement(
              path: 'assets/images/mobile_cat.png', title: 'Mobile'),
          SizedBox(width: 7.w),
          _categoryElement(
              path: 'assets/images/cosmetics_cat.png', title: 'Cosmetics'),
          SizedBox(width: 7.w),
          _categoryElement(
              path: 'assets/images/furniture_cat.png', title: 'Furniture'),
          SizedBox(width: 7.w),
          _categoryElement(
              path: 'assets/images/watch_cat.png', title: 'Watches'),
          SizedBox(width: 7.w),
          _categoryElement(
              path: 'assets/images/fashion_cat.png', title: 'Fashion'),
        ],
      ),
    );
  }

  Widget _categoryElement({required String path, required String title}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CategoryScreen()));
      },
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              path,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.width / 5.w,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchField() {
    return Row(
      children: [
        if (!isStatic)
          Container(
              decoration: BoxDecoration(
                color: AppColorLight.grey1,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back),
              )),
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  isStatic = false;
                });
              } else {
                setState(() {
                  isStatic = true;
                });
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: SvgPicture.asset(
                'assets/vectors/search.svg',
                fit: BoxFit.scaleDown,
              ),
              suffixIcon: !isStatic
                  ? IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          isStatic = true;
                        });
                      },
                      icon: Icon(Icons.close),
                    )
                  : null,
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100.r)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100.r)),
                borderSide: BorderSide(color: AppColorLight.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100.r)),
                borderSide: BorderSide(color: AppColorLight.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
