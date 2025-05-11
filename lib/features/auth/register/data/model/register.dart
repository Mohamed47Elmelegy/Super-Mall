// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// Request Model
class RegistrationModel {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;
  final String phone;

  const RegistrationModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
    required this.phone,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      confirmPassword: json['password_confirmation'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'action': 'register',
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'password_confirmation': confirmPassword,
    };
  }

  RegistrationModel copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? name,
    String? phone,
  }) {
    return RegistrationModel(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  @override
  bool operator ==(covariant RegistrationModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.confirmPassword == confirmPassword &&
        other.name == name &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        confirmPassword.hashCode ^
        name.hashCode ^
        phone.hashCode;
  }

  @override
  String toString() {
    return 'RegistrationModel(email: $email, password: $password, confirmPassword: $confirmPassword, name: $name, phone: $phone)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'name': name,
      'phone': phone,
    };
  }

  factory RegistrationModel.fromMap(Map<String, dynamic> map) {
    return RegistrationModel(
      email: map['email'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
    );
  }
}

// Response Model
class RegisterResponseModel {
  final String status;
  final String message;
  final String? token;

  const RegisterResponseModel({
    required this.status,
    required this.message,
    this.token,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      status: json['status'] as String,
      message: json['message'] as String,
      token: json['token'] as String?,
    );
  }
}
