// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_visitor_admin/widgets/custom_text_field.dart';

class SignupScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup'), centerTitle: true),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            // Lottie animation
            Lottie.asset(
              'images/sign-up.json',
              height: 200,
              width: 200,
              // fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            // Signup form
            CustomTextField(
              hintText: 'enter your email',
              obscureText: false,
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                ).hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: 'enter your password',
              obscureText: true,
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: 'confirm your password',
              obscureText: true,
              prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              controller: confirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                } else if (value != passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Signup button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // Handle signup logic
                }
              },
              child: const Text('Signup',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Login',
                      style: TextStyle(
                        color: Colors.deepOrange,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
