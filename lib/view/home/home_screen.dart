// ignore_for_file: must_be_immutable

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/view-model/auth/auth_view_model.dart';
import 'package:my_visitor_admin/view-model/home/navigator_cubit/navigator_cubit.dart';
import 'package:my_visitor_admin/view/home/contacts/contacts_screen.dart';
import 'package:my_visitor_admin/view/home/settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  AuthViewModel authViewModel = AuthViewModel();
  List<Widget> screens = [ContactsScreen(), SettingsScreen()];
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigatorCubit(),
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Row(
                  children: [
                    Text(
                      authViewModel.auth.currentUser?.displayName ?? S.of(context).admin,
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.verified, color: Colors.deepOrange),
                  ],
                ),
                accountEmail: Text(
                  authViewModel.auth.currentUser?.email ?? "",
                  style: TextStyle(color: Colors.black),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    authViewModel.auth.currentUser?.photoURL ??
                        "https://th.bing.com/th/id/OIP.yNEIwvAlvp4q71Mfj0NZaQHaHa?cb=iwc1&rs=1&pid=ImgDetMain",
                  ),
                ),
                decoration: BoxDecoration(color: Colors.white),
              ),

              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.notification_add, color: Colors.deepOrange),
                title: Text(S.of(context).send_notification),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.deepOrange,
                ),
                onTap:
                    () => Navigator.of(
                      context,
                    ).pushNamed("/SendNotifactionsSendView"),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.support_agent, color: Colors.deepOrange),
                title: Text(S.of(context).support_chats),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.deepOrange,
                ),
                onTap:
                    () => Navigator.of(
                      context,
                    ).pushNamed("/ContactsSupportScreen"),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: OutlinedButton.icon(
                  label: Text(S.of(context).logout),
                  onPressed: () async {
                    await authViewModel.logout();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Icon(Icons.logout),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Image.asset('images/home_logo.png'),
          centerTitle: true,
        ),
        bottomNavigationBar: BlocBuilder<NavigatorCubit, NavigatorStates>(
          builder: (context, state) {
            return CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: Colors.white,
              items: const [
                Icon(
                  Icons.people_outline,
                  color: Colors.black,
                  semanticLabel: 'Contacts',
                  size: 30,
                ),
                Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
                  semanticLabel: 'Settings',
                  size: 30,
                ),
              ],
              onTap: (index) {
                BlocProvider.of<NavigatorCubit>(context).changeIndex(index);
              },
            );
          },
        ),
        backgroundColor: Colors.transparent,
        body: BlocBuilder<NavigatorCubit, NavigatorStates>(
          builder: (context, state) {
            return screens[state.currentIndex];
          },
        ),
      ),
    );
  }
}
