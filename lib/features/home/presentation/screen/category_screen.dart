import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/features/product/logic/cubit/product_cubit.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';
import 'package:super_mall/shared/widget/gridview_primary.dart';
import 'package:super_mall/shared/widget/item.dart';

import '../../../product/logic/cubit/product_state.dart'; // لو تستخدم getIt

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    // استدعي جلب المنتجات عند فتح الصفحة
    context.read<ProductCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            } else if (state is ProductLoaded) {
              return GridViewPrimary(
                items: state.products
                    .map((product) => Item(product: product))
                    .toList(),
                childAspectRatio: 0.7,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
