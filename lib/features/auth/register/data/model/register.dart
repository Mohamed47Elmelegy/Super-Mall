class RegistrationModel {
  final String email;
  final String password;
  final String name;

  const RegistrationModel({
    required this.email,
    required this.password,
    required this.name,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }

  RegistrationModel copyWith({
    String? email,
    String? password,
    String? name,
  }) {
    return RegistrationModel(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RegistrationModel &&
        other.email == email &&
        other.password == password &&
        other.name == name;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ name.hashCode;

  @override
  String toString() => 'Register(email: $email, name: $name)';
}
