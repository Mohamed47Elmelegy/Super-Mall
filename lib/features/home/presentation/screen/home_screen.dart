import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/home/presentation/screen/categories_screen.dart';
import 'package:super_mall/features/home/presentation/widget/home_appbar.dart';
import 'package:super_mall/shared/widget/bottomnavigationbar_primary.dart';
import 'package:super_mall/shared/widget/item.dart';
import 'package:super_mall/features/product/logic/cubit/product_cubit.dart';
import 'package:super_mall/features/product/data/model/product.dart';
import '../../../../core/routes/page_routes_name.dart';
import '../../../product/logic/cubit/product_state.dart';
import '../../data/model/category.dart';
import '../cubit/category_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screenPadding = 20.w;
  TextEditingController searchController = TextEditingController();
  bool isStatic = true;

  @override
  void initState() {
    super.initState();
    // جلب المنتجات والأقسام عند فتح الصفحة
    context.read<ProductCubit>().getProducts();
    context.read<CategoryCubit>().getCategories();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, productState) {
        return BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, categoryState) {
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
                      if (productState is ProductLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (productState is ProductError)
                        Center(child: Text(productState.message))
                      else if (productState is ProductLoaded)
                        _buildDefaultContent(
                            context, productState.products, categoryState)
                      else
                        const SizedBox(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDefaultContent(BuildContext context, List<Product> products,
      CategoryState categoryState) {
    // فلترة المنتجات حسب القسم
    final topSelling = products.where((p) => p.isBest).toList();
    final newIn = products.where((p) => p.isNew).toList();

    return Column(
      children: [
        SizedBox(height: 20.h),
        _itemsHeader('Categories', 'See All', action: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CategoriesScreen()));
        }),
        SizedBox(height: 20.h),
        _categoriesElements(categoryState),
        SizedBox(height: 20.h),
        _itemsHeader('Top Selling', 'See All', action: () {}),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                topSelling.map((product) => Item(product: product)).toList(),
          ),
        ),
        SizedBox(height: 20.h),
        _itemsHeader('New In', 'See All', action: () {}),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: newIn.map((product) => Item(product: product)).toList(),
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

  Widget _categoriesElements(CategoryState categoryState) {
    if (categoryState is CategoryLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (categoryState is CategoryError) {
      return Center(child: Text(categoryState.message));
    } else if (categoryState is CategoryLoaded) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: categoryState.categories.map((category) {
            return Padding(
              padding: EdgeInsets.only(right: 7.w),
              child: _categoryElement(
                path: category.image,
                title: category.name['en'] ?? category.name['ar'] ?? '',
                category: category,
              ),
            );
          }).toList(),
        ),
      );
    }
    return const SizedBox(); // fallback
  }

  Widget _categoryElement(
      {required String path, required String title, Category? category}) {
    return InkWell(
      onTap: () {
        if (category != null) {
          Navigator.pushNamed(context, PageRoutesName.category,
              arguments: category);
        }
      },
      child: Column(
        children: [
          ClipOval(
            child: path.startsWith('http')
                ? Image.network(
                    path,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 5.w,
                    width: MediaQuery.of(context).size.width / 5.w,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.category,
                          size: MediaQuery.of(context).size.width / 5.w);
                    },
                  )
                : Image.asset(
                    path,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 5.w,
                  ),
          ),
          SizedBox(height: 5.h),
          Text(
            title,
            style: TextStyle(fontSize: 12.sp),
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
              setState(() {
                isStatic = value.isEmpty;
              });
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

  // مثال على استخدام Wrap بدلاً من Row للفلاتر (لو عندك فلاتر كثيرة):
  Widget _filtersBar(List<String> filters) {
    return Wrap(
      spacing: 8.0,
      children: filters
          .map((filter) => Chip(
                label: Text(filter),
              ))
          .toList(),
    );
  }
}
