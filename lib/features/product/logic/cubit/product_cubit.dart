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
      final allProducts = await repository.fetchAllProducts();
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

  Future<void> getProductById(String productCode) async {
    emit(ProductLoading());
    try {
      // In a real app, you would have a dedicated API endpoint for this
      // Here we're simulating by fetching all products and filtering
      final allProducts = await repository.fetchProducts();

      final product = allProducts.firstWhere(
        (product) => product.code == productCode,
        orElse: () => throw Exception('Product not found'),
      );

      emit(ProductDetailLoaded(product));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
