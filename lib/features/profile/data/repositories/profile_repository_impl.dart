import '../../domain/repositories/profile_repository.dart';
import '../models/profile_model.dart';
import '../services/profile_service.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileService _profileService;

  ProfileRepositoryImpl(this._profileService);

  @override
  Future<ProfileModel> getProfile() async {
    return await _profileService.getProfile();
  }

  @override
  Future<ProfileModel> updateProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    return await _profileService.updateProfile(
      name: name,
      email: email,
      phone: phone,
    );
  }
}
