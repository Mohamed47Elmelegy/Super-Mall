import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/features/home/presentation/screen/categories_screen.dart';
import 'package:super_mall/features/home/presentation/widget/home_appbar.dart';
import 'package:super_mall/shared/widget/bottomnavigationbar_primary.dart';
import 'package:super_mall/shared/widget/item.dart';
import 'package:super_mall/shared/widget/skeleton_screen.dart';
import '../../../../core/routes/page_routes_name.dart';
import '../../data/model/category.dart';
import '../../logic/cubit/banner_cubit.dart';
import '../cubit/category_cubit.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widget/banner_carousel.dart';
import '../screen/products_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  double screenPadding = 20.w;
  TextEditingController searchController = TextEditingController();
  bool isStatic = true;
  bool _dataFetched = false;

  @override
  void initState() {
    super.initState();
    // جلب البيانات مرة واحدة فقط
    if (!_dataFetched) {
      context.read<HomeCubit>().loadHomeData();
      context.read<CategoryCubit>().getCategories();
      context.read<BannerCubit>().getBanners();
      _dataFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, homeState) {
        return BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, categoryState) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBarPrimary(
                currentIndex: 0,
                onTap: (p0) {},
              ),
              appBar: HomeAppbar(),
              body: RefreshIndicator(
                onRefresh: () async {
                  await context.read<HomeCubit>().loadHomeData();
                  // await context.read<CategoryCubit>().getCategories();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenPadding),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        const BannerCarousel(),
                        SizedBox(height: 20.h),
                        _searchField(),

                        if (homeState is HomeLoading)
                          const SkeletonHomeScreen()
                        else if (homeState is HomeError)
                          Center(child: Text(homeState.message))
                        else if (homeState is HomeLoaded)
                          _buildDefaultContent(
                              context, homeState, categoryState)
                        else
                          const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildDefaultContent(
      BuildContext context, HomeLoaded homeState, CategoryState categoryState) {
    final topSelling = homeState.homeData.topSelling.take(5).toList();
    final newIn = homeState.homeData.newProducts.take(5).toList();

    return Column(
      children: [
        SizedBox(height: 20.h),
        _itemsHeader('Categories', 'See All', action: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CategoriesScreen()));
        }),
        SizedBox(height: 20.h),
        _buildCategoriesSection(categoryState),
        SizedBox(height: 20.h),
        _itemsHeader('Top Selling', 'See All', action: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsListScreen(
                title: 'Top Selling',
                type: 'topSelling',
              ),
            ),
          );
        }),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                topSelling.map((product) => Item(product: product)).toList(),
          ),
        ),
        SizedBox(height: 20.h),
        _itemsHeader('New In', 'See All', action: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsListScreen(
                title: 'New In',
                type: 'newIn',
              ),
            ),
          );
        }),
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

  Widget _buildCategoriesSection(CategoryState categoryState) {
    if (categoryState is CategoryLoading) {
      return SizedBox(height: 120.h); // Placeholder for skeleton
    } else if (categoryState is CategoryError) {
      return Center(child: Text(categoryState.message));
    } else if (categoryState is CategoryLoaded) {
      return _buildCategoriesList(categoryState.categories);
    }
    return const SizedBox.shrink();
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

  Widget _buildCategoriesList(List<Category> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: categories.map((category) {
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
}
