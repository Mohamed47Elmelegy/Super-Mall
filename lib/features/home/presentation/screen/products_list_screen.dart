import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/features/product/logic/cubit/product_cubit.dart';
import 'package:super_mall/features/product/logic/cubit/product_state.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/item.dart';
import 'package:super_mall/shared/widget/skeleton_screen.dart';

class ProductsListScreen extends StatefulWidget {
  final String title;
  final String type; // 'topSelling' or 'newIn'

  const ProductsListScreen({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    if (widget.type == 'topSelling') {
      context.read<ProductCubit>().getTopSellingProducts();
    } else if (widget.type == 'newIn') {
      context.read<ProductCubit>().getNewProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(title: widget.title),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadProducts();
        },
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const SkeletonProductsListScreen();
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            } else if (state is ProductLoaded) {
              if (state.products.isEmpty) {
                return const Center(child: Text('No products found'));
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return Item(product: state.products[index]);
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
