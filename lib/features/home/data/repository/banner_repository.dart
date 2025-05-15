import 'dart:developer';

import 'package:super_mall/core/network/api_client.dart';
import 'package:super_mall/core/network/api_constants.dart';
import '../model/banner.dart';

class BannerRepository {
  final ApiClient _apiClient;

  BannerRepository(this._apiClient);

  Future<List<Banner>> getBanners() async {
    try {
      //sora seeds/banners/slide-gocery2.jpg laz
      final response = await _apiClient.get(ApiConstants.banners);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        log(data[0].toString());
        return data.map((json) => Banner.fromJson(json)).toList();
      }
      throw Exception('Failed to load banners');
    } catch (e) {
      throw Exception('Failed to load banners: $e');
    }
  }
}
