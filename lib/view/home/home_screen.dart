import 'package:flutter/material.dart';
import 'package:my_visitor_admin/view-model/auth/auth_view_model.dart';

class HomeScreen extends StatelessWidget {
  AuthViewModel authViewModel = AuthViewModel();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed:() => authViewModel.logout(),
          child: const Text('Logout'),
        ),
      ),
    );
  }
}