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
}
