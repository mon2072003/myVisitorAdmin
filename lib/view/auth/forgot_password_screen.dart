import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/view-model/auth/auth_view_model.dart';
import 'package:my_visitor_admin/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthViewModel authViewModel = AuthViewModel();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).forgot_password), centerTitle: true),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Lottie.asset(
              'images/forgot_password.json',
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  authViewModel.resetPassword(emailController.text.trim());
                }
              },
              child:  Text(
                S.of(context).reset_password,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}