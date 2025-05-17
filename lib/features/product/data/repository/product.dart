import 'dart:developer';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_constants.dart';
import '../model/product.dart';

class ProductRepository {
  final ApiClient _apiClient;
  ProductRepository(this._apiClient);

  Future<List<Product>> fetchProducts() async {
    final response = await _apiClient.get(ApiConstants.products);
    final List data = response.data['data'];
    return data.map((json) => Product.fromJson(json)).toList();
  }

  Future<List<Product>> getTopSellingProducts() async {
    final response = await _apiClient.get(
      ApiConstants.products,
      queryParameters: {'best': 'true'},
    );
    final List data = response.data['data'];
    return data.map((json) => Product.fromJson(json)).toList();
  }

  Future<List<Product>> getNewProducts() async {
    final response = await _apiClient.get(
      ApiConstants.products,
      queryParameters: {'new': 'true'},
    );
    final List data = response.data['data'];
    return data.map((json) => Product.fromJson(json)).toList();
  }

Future<List<Product>> fetchProductsByCategory(String categorySlug) async {
  log('Requesting products for category: $categorySlug');
  
  final response = await _apiClient.get(
    ApiConstants.products,
    queryParameters: {
      'category': categorySlug,
    },
  );
  
  final List data = response.data['data'];
  log('\x1B[31mTotal products found: [0m${data.length}');
  
  List<Product> products = data.map((json) {
    final product = Product.fromJson(json);
    log('Product: [0m${product.name['en']} - Category: ${product.category['en']}');
    return product;
  }).toList();

  return products;
}
}
