import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/product.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitial());

  Future<void> getProducts() async {
    emit(ProductLoading());
    try {
      final products = await repository.fetchProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> getProductsByCategory(String categoryEn) async {
    emit(ProductLoading());
    try {
      // جلب كل المنتجات الأول
      final allProducts = await repository.fetchProducts();

      // فلترة المنتجات client-side
      final filteredProducts = allProducts
          .where((product) =>
              product.category['en'] == categoryEn ||
              product.category['ar'] == categoryEn)
          .toList();

      emit(ProductLoaded(filteredProducts));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
