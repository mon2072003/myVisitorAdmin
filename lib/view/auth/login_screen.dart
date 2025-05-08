// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_visitor_admin/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            // Lottie animation
            Lottie.asset(
              'images/login.json',
              height: 200,
              width: 200,
              // fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            // Login form
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
              prefixIcon: Icons.password,
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Login button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:Colors.deepOrange
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {}
              },
              child: const Text('Login',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('Sign Up',
                      style: TextStyle(
                        color: Colors.deepOrange,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(child: Divider()),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('or'),
                ),
                const Expanded(child: Divider()),
              ],
            ),
      
            const SizedBox(height: 20),
            // Google outline button
            OutlinedButton.icon(
              onPressed: () {
                // Handle Google signup
              },
              icon: Image.asset('images/google.png', height: 20),
              label: const Text('Signup with Google',
                  style: TextStyle(
                    color: Colors.black,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
