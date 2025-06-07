import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
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
      appBar: AppBar(
        title: Text(S.of(context).change_password),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Lottie.asset('images/society.json', height: 200, width: 200),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: S.of(context).enter_your_new_password,
              obscureText: true,
              prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              controller: newPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_enter_your_new_password;
                } else if (value.length < 6) {
                  return S.of(context).password_must_be_at_least_6_characters;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: S.of(context).confirm_password,
              obscureText: true,
              prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              controller: confirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).please_confirm_your_new_password;
                } else if (value != newPasswordController.text) {
                  return S.of(context).passwords_do_not_match;
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
                  authViewModel
                      .changePassword(newPasswordController.text.trim())
                      .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              S.of(context).password_changed_successfully,
                            ),
                          ),
                        );
                        Navigator.pop(
                          context,
                        ); // Go back to the previous screen
                      })
                      .catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "this method requires recent login session",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      });
                }
              },
              child: Text(
                S.of(context).change_password,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
