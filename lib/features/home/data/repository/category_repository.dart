import 'package:super_mall/core/network/api_client.dart';
import 'package:super_mall/core/network/api_constants.dart';
import '../../../product/data/model/product.dart';
import '../model/category_model.dart';

class CategoryRepository {
  final ApiClient apiClient;
  CategoryRepository(this.apiClient);

  Future<List<Category>> getCategories() async {
    final response = await apiClient.get(ApiConstants.categories);
    final List data = response.data['data'];
    return data.map((json) => Category.fromJson(json)).toList();
  }

  // Future<List<Product>> fetchProductsByCategory(String categoryEn) async {
  //   final response = await apiClient.get(
  //     ApiConstants.products,
  //     queryParameters: {'category': categoryEn},
  //   );
  //   final List data = response.data['data'];
  //   return data.map((json) => Product.fromJson(json)).toList();
  // }
}
