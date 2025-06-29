// ignore_for_file: must_be_immutable

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/constants.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/model/contacts/contacts_model.dart';
import 'package:my_visitor_admin/services/contacts/contacts.dart';
import 'package:my_visitor_admin/view-model/auth/auth_view_model.dart';
import 'package:my_visitor_admin/view-model/home/navigator_cubit/navigator_cubit.dart';
import 'package:my_visitor_admin/view/home/contacts/contact_info/contact_info.dart';
import 'package:my_visitor_admin/view/home/contacts/contacts_screen.dart';
import 'package:my_visitor_admin/view/home/cities/cities_screen.dart';
import 'package:my_visitor_admin/view/home/settings/settings_screen.dart';
import 'package:my_visitor_admin/widgets/search_contacts_delegate.dart';

class HomeScreen extends StatelessWidget {
  AuthViewModel authViewModel = AuthViewModel();
  List<Widget> screens = [ContactsScreen(),CitiesScreen(), SettingsScreen()];
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
                      authViewModel.auth.currentUser?.displayName ??
                          S.of(context).admin,
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
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.deepOrange,
                ),
                title: Text(S.of(context).view_profile),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.deepOrange,
                ),
                onTap: () async{
                  ContactsModel? user = await ContactsAPI.getCurrentUserByEmail(
                    FirebaseAuth.instance.currentUser!.email!,
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ContactInfo(
                        contacts: user!,
                      ),
                    ),
                  );
                },
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
              ListTile(
                leading: Icon(Icons.info_outline, color: Colors.deepOrange),
                title: Text(S.of(context).about_us),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.deepOrange,
                ),
                onTap:
                    () => Navigator.of(
                      context,
                    ).pushNamed("/about-us"),
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
            title: Image.asset(
            'images/home_logo.png',
            color: Colors.amber,
            filterQuality: FilterQuality.high,
            ),
          centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.deepOrange, size: 30),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchContactsDelegate(contacts: contacts),
              );
            },
          ),
        ],
        ),
        bottomNavigationBar: BlocBuilder<NavigatorCubit, NavigatorStates>(
          builder: (context, state) {
            return CurvedNavigationBar(
              height: 60,
              backgroundColor:Colors.black,
              color: const Color.fromARGB(255, 30, 30, 30), 
              buttonBackgroundColor: const Color.fromARGB(255, 85, 55, 10),
              animationDuration: const Duration(milliseconds: 600),
              animationCurve: Curves.easeInOut,
              items: [
                Icon(
                  Icons.people_outline,
                  color: state.currentIndex== 0? Colors.deepOrange:Colors.white,
                  semanticLabel: 'Contacts',
                  size: 35,
                ),
                Icon(
                  Icons.place_outlined,
                  color: state.currentIndex== 1? Colors.deepOrange:Colors.white,
                  semanticLabel: 'Places',
                  size: 35,
                ),
                Icon(
                  Icons.settings_outlined,
                  color: state.currentIndex== 2? Colors.deepOrange:Colors.white,
                  semanticLabel: 'Settings',
                  size: 35,
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
