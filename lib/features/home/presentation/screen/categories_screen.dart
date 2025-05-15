import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/core/theme/app_color/app_color_light.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/skeleton_screen.dart';
import '../../../../core/routes/page_routes_name.dart';
import '../cubit/category_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  double screenPadding = 20.w;

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(title: 'Categories'),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<CategoryCubit>().getCategories();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shop by Categories',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return const SkeletonCategoriesScreen();
                    } else if (state is CategoryError) {
                      return Center(child: Text(state.message));
                    } else if (state is CategoryLoaded) {
                      return ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.categories.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 7.h),
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return _categoryItem(
                            category.name['en'] ?? category.name['ar'] ?? '',
                            category.image,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PageRoutesName.category,
                                arguments: category,
                              );
                            },
                          );
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryItem(String title, String path, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColorLight.grey1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipOval(
              child: path.startsWith('http')
                  ? Image.network(
                      path,
                      height: 45.h,
                      width: 45.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.category, size: 45.h);
                      },
                    )
                  : Image.asset(
                      path,
                      height: 45.h,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
