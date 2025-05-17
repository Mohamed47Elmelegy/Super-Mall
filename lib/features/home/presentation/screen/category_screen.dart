import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/features/home/data/model/category.dart';
import 'package:super_mall/features/product/logic/cubit/product_cubit.dart';
import 'package:super_mall/features/product/logic/cubit/product_state.dart';
import 'package:super_mall/shared/widget/animated_product_list.dart';
import 'package:super_mall/shared/widget/skeleton_screen.dart';
import 'package:super_mall/features/product/presentation/screen/product_empty_screen.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  const CategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context
        .read<ProductCubit>()
        .getProductsByCategory(widget.category.name['en'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.category.name['en'] ?? widget.category.name['ar'] ?? ''),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context
              .read<ProductCubit>()
              .getProductsByCategory(widget.category.name['en'] ?? '');
        },
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const SkeletonCategoryScreen();
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            } else if (state is ProductLoaded) {
              if (state.products.isEmpty) {
                return const ProductEmptyScreen();
              }
              return AnimatedProductList(
                products: state.products,
                childAspectRatio: 0.65,
                crossAxisCount: 2,
                spacing: 16,
                padding: const EdgeInsets.all(16),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
