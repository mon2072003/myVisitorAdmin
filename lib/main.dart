import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_visitor_admin/view/home/chats/chat_view.dart';
import 'package:my_visitor_admin/view/home/chats/contacts_view.dart';
import 'package:my_visitor_admin/view/auth/forgot_password_screen.dart';
import 'package:my_visitor_admin/view/auth/login_screen.dart';
import 'package:my_visitor_admin/view/home/home_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyVisitorAdmin());
}

class MyVisitorAdmin extends StatelessWidget {
  const MyVisitorAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Visitor Admin',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        fontFamily: 'Schyler',
      ),

      initialRoute:
          FirebaseAuth.instance.currentUser != null ? '/home' : '/login',
      routes: {
        '/home': (context) => HomeScreen(),
        '/forgot-password':(context) => ForgotPasswordScreen(),
        '/login': (context) => LoginScreen(),
        '/ContactsSupportScreen': (context) => ContactsSupportScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == ChatView.id) {
          final contactEmail = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => ChatView(contactEmail: contactEmail),
          );
        }
        return null;
      },
    );
  }
}
