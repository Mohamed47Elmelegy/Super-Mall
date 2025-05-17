import 'package:dio/dio.dart';
import '../models/profile_model.dart';

class ProfileService {
  final Dio _dio;

  ProfileService(this._dio);

  Future<ProfileModel> getProfile() async {
    try {
      final response = await _dio.get('http://10.0.2.2:8000/api/users/1');
      return ProfileModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  Future<ProfileModel> updateProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final response = await _dio.put(
        '/profile',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        },
      );
      return ProfileModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
