// class LoginModel {
//   final String action;
//   final String email;
//   final String password;

//   LoginModel({
//     required this.action,
//     required this.email,
//     required this.password,
//   });

//   factory LoginModel.fromJson(Map<String, dynamic> json) {
//     return LoginModel(
//       action: json['action'] as String,
//       email: json['email'] as String,
//       password: json['password'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'action': action,
//       'email': email,
//       'password': password,
//     };
//   }

//   LoginModel copyWith({
//     String? action,
//     String? email,
//     String? password,
//   }) {
//     return LoginModel(
//       action: action ?? this.action,
//       email: email ?? this.email,
//       password: password ?? this.password,
//     );
//   }

//   @override
//   String toString() {
//     return 'LoginModel(action: $action, email: $email, password: $password)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is LoginModel &&
//         other.action == action &&
//         other.email == email &&
//         other.password == password;
//   }

//   @override
//   int get hashCode => action.hashCode ^ email.hashCode ^ password.hashCode;
// }
