import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/model/contacts/contacts_model.dart';
import 'package:my_visitor_admin/view-model/auth/auth_view_model.dart';
import 'package:my_visitor_admin/view-model/home/settings/change_account_cubit/account_cubit.dart';
import 'package:my_visitor_admin/widgets/custom_text_field.dart';

class ChangeAccountInfoScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthViewModel authViewModel = AuthViewModel();
  ContactsModel contactModel;

  ChangeAccountInfoScreen({super.key, required this.contactModel}) {
    nameController.text = contactModel.name!;
    phoneController.text = contactModel.phoneNumber!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).change_account_info),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  return state.localImage != null
                      ? Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            File(state.localImage!.path),
                            height: 200,
                            width: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                      : Lottie.asset(
                        'images/account_info.json',
                        height: 200,
                        width: 200,
                      );
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: S.of(context).enter_your_name,
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).please_enter_your_name;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: S.of(context).enter_your_phone_number,
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                controller: phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).please_enter_your_phone_number;
                  } else if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                    return S.of(context).please_enter_a_valid_phone_number;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () async {
                      context.read<AccountCubit>().selectImage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    child: Text(
                      S.of(context).select_image,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await context.read<AccountCubit>().changeAccountInfo(
                          name: nameController.text,
                          email: FirebaseAuth.instance.currentUser!.email!,
                          phoneNumber: phoneController.text,
                        );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              S.of(context).account_info_updated_successfully,
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    child: Text(
                      S.of(context).update_info,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
