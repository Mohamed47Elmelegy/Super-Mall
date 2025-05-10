// abstract class LoginRepositoryBase {
//   Future<void> login(String email, String password);
//   Future<void> loginWithGoogle();
//   Future<void> loginWithFacebook(); 
//   Future<void> resetPassword(String email);
// }

// class LoginRepository implements LoginRepositoryBase {
//   @override
//   Future<void> login(String email, String password) async {
//     try {
//       // Implement login logic here
//       // Make API call or authenticate with backend
//     } catch (e) {
//       throw Exception('Login failed: $e');
//     }
//   }

//   @override 
//   Future<void> loginWithGoogle() async {
//     try {
//       // Implement Google sign in logic
//     } catch (e) {
//       throw Exception('Google login failed: $e');
//     }
//   }

//   @override
//   Future<void> loginWithFacebook() async {
//     try {
//       // Implement Facebook login logic  
//     } catch (e) {
//       throw Exception('Facebook login failed: $e');
//     }
//   }

//   @override
//   Future<void> resetPassword(String email) async {
//     try {
//       // Implement password reset logic
//     } catch (e) {
//       throw Exception('Password reset failed: $e'); 
//     }
//   }
// }