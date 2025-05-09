import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_visitor_admin/chat/presentation/views/chat_view.dart';
import 'package:my_visitor_admin/chat/presentation/views/contacts_view.dart';
import 'package:my_visitor_admin/view/auth/login_screen.dart';
import 'package:my_visitor_admin/view/auth/signup_screen.dart';
import 'package:my_visitor_admin/view/home/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        fontFamily: 'Schyler',
      ),

      initialRoute:
          FirebaseAuth.instance.currentUser != null ? '/home' : '/login',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) =>  LoginScreen(),
        '/signup': (context) =>  SignupScreen(),
        '/ContactsScreen':(context)=>ContactsScreen(),
      },
       onGenerateRoute: (settings) {
    if (settings.name == ChatView.id) {
      final contactEmail = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => ChatView(contactEmail: contactEmail),
      );
    }

    
  },
    );
  }
}
