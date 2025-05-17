
import 'package:super_mall/core/network/api_client.dart';
import 'package:super_mall/core/network/api_constants.dart';
import '../model/banner.dart';

class BannerRepository {
  final ApiClient _apiClient;

  BannerRepository(this._apiClient);

  Future<List<Banner>> getBanners() async {
    try {
      
      final response = await _apiClient.get(ApiConstants.banners);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => Banner.fromJson(json)).toList();
      }
      throw Exception('Failed to load banners');
    } catch (e) {
      throw Exception('Failed to load banners: $e');
    }
  }
}
