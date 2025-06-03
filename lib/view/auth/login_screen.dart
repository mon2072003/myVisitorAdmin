// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/services/contacts/contacts.dart';
import 'package:my_visitor_admin/view-model/auth/auth_view_model.dart';
import 'package:my_visitor_admin/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthViewModel authViewModel = AuthViewModel();
  Future<UserCredential>? credintial;
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).login), centerTitle: true),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
              hintText: S.of(context).enter_your_email,
              obscureText: false,
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_enter_your_email;
                } else if (!RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                ).hasMatch(value)) {
                  return S.of(context).please_enter_a_valid_email;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: S.of(context).enter_your_password,
              obscureText: true,
              prefixIcon: Icons.password,
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_enter_your_password;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Login button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  bool isAdmin = await ContactsAPI.isAdmin(
                    emailController.text.trim(),
                  );

                  if (isAdmin == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          S.of(context).you_are_not_admin,
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  credintial = authViewModel.login(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );

                  credintial!.then((value) {
                    if (value.user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            S.of(context).login_failed,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            S.of(context).login_successful,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (route) => false,
                      );
                    }
                  });
                }
              },
              child: const Text('Login', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).forgot_password,
                  // style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: Text(
                    S.of(context).change_password,
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
