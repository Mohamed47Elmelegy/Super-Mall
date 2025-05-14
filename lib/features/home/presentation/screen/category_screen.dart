import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_mall/features/product/logic/cubit/product_cubit.dart';
import 'package:super_mall/shared/widget/item.dart';

import '../../../product/logic/cubit/product_state.dart';
import '../../data/model/category.dart'; // لو تستخدم getIt

class CategoryScreen extends StatefulWidget {
  final Category category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with AutomaticKeepAliveClientMixin {
  bool _dataFetched = false;

  @override
  void initState() {
    super.initState();
    // جلب المنتجات الخاصة بالقسم مرة واحدة فقط
    if (!_dataFetched) {
      context
          .read<ProductCubit>()
          .getProductsByCategory(widget.category.name['en'] ?? '');
      _dataFetched = true;
    }
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
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            } else if (state is ProductLoaded) {
              if (state.products.isEmpty) {
                return Center(child: Text('No products found'));
              }
              return GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return Item(product: state.products[index]);
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
