import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/model/contacts/contacts_model.dart';
import 'package:my_visitor_admin/services/contacts/contacts.dart';
import 'package:my_visitor_admin/view-model/home/settings/app-cubit/app_cubit.dart';
import 'package:my_visitor_admin/view/home/settings/change-account-info/change_account_info_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.edit, color: Colors.deepOrange),
              title: Text(S.of(context).change_account_info),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.deepOrange,
              ),
              onTap: () async {
                ContactsModel? contactModel = await ContactsAPI.getCurrentUserByEmail(FirebaseAuth.instance.currentUser!.email!);
                Navigator.of(context).push(MaterialPageRoute(builder:
                  (context) => ChangeAccountInfoScreen(
                    contactModel: contactModel!,
                  ),
                ));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.password_outlined, color: Colors.deepOrange),
              title: Text(S.of(context).change_password),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.deepOrange,
              ),
              onTap: () => Navigator.of(context).pushNamed("/change-password"),
            ),
          ),
          Card(
            child: BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                if (state is AppInitial) {
                  BlocProvider.of<AppCubit>(context).getDarkeness();
                }
                return SwitchListTile(
                  value: state.darkeness,
                  onChanged: (value) {
                    BlocProvider.of<AppCubit>(context).setDarkeness(value);
                  },
                  activeTrackColor: Colors.deepOrange,
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.deepOrange,
                  title: Text(S.of(context).set_darkeness),
                  subtitle: Text(S.of(context).you_can_switch_on_and_off_the_button),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.language, color: Colors.deepOrange),
              title: Text(S.of(context).choose_application_language),
              subtitle: Text(S.of(context).you_can_drop_and_choose_from_the_menu),
              trailing: BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  if (state is AppInitial) {
                    BlocProvider.of<AppCubit>(context).getLanguage();
                  }
                  return DropdownButton(
                    underline: SizedBox(),
                    value: state.language,
                    items: [
                      DropdownMenuItem(value: "en", child: Text("en")),
                      DropdownMenuItem(value: "ar", child: Text("ar")),
                    ],
                    onChanged: (value) {
                      BlocProvider.of<AppCubit>(context).setLanguage(value!);
                      S.load(Locale(value));
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
