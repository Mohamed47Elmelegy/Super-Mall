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

  Future<void> getProductsByCategory(String categorySlug) async {
    emit(ProductLoading());
    try {
      final response = await repository.fetchProductsByCategory(categorySlug);
      emit(ProductLoaded(response));
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

  Future<void> getTopSellingProducts() async {
    emit(ProductLoading());
    try {
      final products = await repository.getTopSellingProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> getNewProducts() async {
    emit(ProductLoading());
    try {
      final products = await repository.getNewProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
