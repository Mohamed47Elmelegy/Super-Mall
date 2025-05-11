// Request Model
class UserLoginModel {
  final String email;
  final String password;

  const UserLoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'action': 'login',
      'email': email,
      'password': password,
    };
  }
}

// Response Model
class LoginResponseModel {
  final String? token;
  final UserData? user;
  final String? status;
  final String? message;

  const LoginResponseModel({
    this.token,
    this.user,
    this.status,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] as String?,
      user: json['user'] != null ? UserData.fromJson(json['user']) : null,
      status: json['status'] as String?,
      message: json['message'] as String?,
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? avatar;
  final String? phone;
  final String? roleId;
  final String? oauthProvider;
  final String? oauthId;
  final String createdAt;
  final String updatedAt;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.avatar,
    this.phone,
    this.roleId,
    this.oauthProvider,
    this.oauthId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_at'] as String?,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      roleId: json['role_id'] as String?,
      oauthProvider: json['oauth_provider'] as String?,
      oauthId: json['oauth_id'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }
}
