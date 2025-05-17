import 'dart:convert';
import 'dart:developer';
import 'package:super_mall/features/user/user_info/data/model/user_model.dart';
import 'package:super_mall/core/constants/shared_prefs.dart';
import 'package:super_mall/core/services/shared_preferences_sengltion.dart';

Future<void> saveUserData(UserModel user) async {
  final jsonString = jsonEncode(user.toJson());
  await Prefs.setString(SharedPrefs.userData, jsonString);

  final userData = user.toJson();

  for (final entry in userData.entries) {
    final key = entry.key;
    final value = entry.value;

    if (value != null && value is String && value.isNotEmpty) {
      switch (key) {
        case 'id':
          await Prefs.setString(SharedPrefs.userId, value);
          break;
        case 'name':
          await Prefs.setString(SharedPrefs.userName, value);
          break;
        case 'email':
          await Prefs.setString(SharedPrefs.userEmail, value);
          break;
        case 'phone':
          await Prefs.setString(SharedPrefs.userPhone, value);
          break;
        case 'image':
          await Prefs.setString(SharedPrefs.userImage, value);
          break;
        case 'token':
          await Prefs.setString(SharedPrefs.token, value);
          break;
      }
    }
  }
}

// استرجاع بيانات المستخدم من SharedPreferences
UserModel? getUserData() {
  final jsonString = Prefs.getString(SharedPrefs.userData);
  if (jsonString == null) return null;
  try {
    return UserModel.fromJson(jsonDecode(jsonString));
  } catch (e) {
    log('Error parsing user data: $e');
    return null;
  }
}

Future<void> clearUserData() async {
  await Prefs.remove(SharedPrefs.userData);
  await Prefs.remove(SharedPrefs.token);
  await Prefs.remove(SharedPrefs.userId);
  await Prefs.remove(SharedPrefs.userName);
  await Prefs.remove(SharedPrefs.userEmail);
  await Prefs.remove(SharedPrefs.userPhone);
  await Prefs.remove(SharedPrefs.userImage);
}

bool isUserLoggedIn() {
  final token = Prefs.getString(SharedPrefs.token);
  return token != null && token.isNotEmpty;
}
