import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_visitor_admin/view-model/auth/auth_view_model.dart';
import 'package:my_visitor_admin/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthViewModel authViewModel = AuthViewModel();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password'), centerTitle: true),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Lottie.asset(
              'images/society.json',
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: 'Enter your new password',
              obscureText: true,
              prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              controller: newPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your new password';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: 'Confirm your new password',
              obscureText: true,
              prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              controller: confirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your new password';
                } else if (value != newPasswordController.text) {
                  return 'Passwords do not match';
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
                  authViewModel.changePassword(newPasswordController.text.trim()).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password changed successfully')),
                    );
                    Navigator.pop(context); // Go back to the previous screen
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    );
                  });
                }
              },
              child: const Text(
                'Change Password',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}