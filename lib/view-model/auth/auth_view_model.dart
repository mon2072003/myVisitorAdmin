import 'package:firebase_auth/firebase_auth.dart';

class AuthViewModel {
  var auth = FirebaseAuth.instance;
  // Add your authentication logic here
  Future<UserCredential> login(String email, String password) async {
    // Implement login logic
    var userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  }

  Future<void> logout() async {
    // Implement logout logic
    await auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    // Implement password reset logic
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> changePassword(String newPassword) async {
    // Implement change password logic
    var user = auth.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
    }
  }

  Future<void> forgotPassword(String email) async {
    // Implement forgot password logic
    await auth.sendPasswordResetEmail(email: email);
  }
}
