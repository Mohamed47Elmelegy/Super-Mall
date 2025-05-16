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
      queryParameters: {'sort': 'best_selling'},
    );
    final List data = response.data['data'];
    return data.map((json) => Product.fromJson(json)).toList();
  }

  Future<List<Product>> getNewProducts() async {
    final response = await _apiClient.get(
      ApiConstants.products,
      queryParameters: {'sort': 'newest'},
    );
    final List data = response.data['data'];
    return data.map((json) => Product.fromJson(json)).toList();
  }

  Future<List<Product>> fetchAllProducts() async {
    List<Product> allProducts = [];
    int page = 1;
    int perPage = 15; // سيتم تحديثها من أول استجابة
    int total = 0;
    bool firstResponse = true;

    do {
      log('Requesting page: $page');
      final response = await _apiClient.get(
        ApiConstants.products,
        queryParameters: {'page': page},
      );
      final List data = response.data['data'];
      log('\x1B[31mPage $page: عدد المنتجات =  [0m${data.length}');
      allProducts.addAll(data.map((json) {
        final product = Product.fromJson(json);
        log('Product: [0m${product.name['en']} - Category: ${product.category['en']}');
        return product;
      }).toList());

      if (firstResponse) {
        // احصل على per_page و total من أول استجابة
        perPage = response.data['per_page'] ?? perPage;
        total = response.data['total'] ?? 0;
        firstResponse = false;
      }

      page++;
    } while (allProducts.length < total);

    return allProducts;
  }
}
