import 'package:firebase_auth/firebase_auth.dart';

class AuthViewModel {
  var auth =FirebaseAuth.instance;
  // Add your authentication logic here
  void login(String email, String password) async{
    // Implement login logic
   await auth.signInWithEmailAndPassword(email: email, password: password);
  }
  void signup(String email, String password) async{
    // Implement signup logic
   await auth.createUserWithEmailAndPassword(email: email, password: password);
  }
  void logout() async{
    // Implement logout logic
   await auth.signOut();
  }
  void resetPassword(String email) async{
    // Implement password reset logic
    await auth.sendPasswordResetEmail(email: email);
  }
}