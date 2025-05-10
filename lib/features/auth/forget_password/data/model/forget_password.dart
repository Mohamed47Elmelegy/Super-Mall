class ForgetPassword {
  final String email;

  const ForgetPassword({
    required this.email,
  });

  factory ForgetPassword.fromJson(Map<String, dynamic> json) {
    return ForgetPassword(
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
