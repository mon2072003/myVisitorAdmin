// ignore_for_file: must_be_immutable

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/view-model/auth/auth_view_model.dart';
import 'package:my_visitor_admin/view-model/home/navigator_cubit/navigator_cubit.dart';
import 'package:my_visitor_admin/view/home/contacts/contact_screen.dart';
import 'package:my_visitor_admin/view/home/dashboard/dashboard_screen.dart';
import 'package:my_visitor_admin/view/home/settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  AuthViewModel authViewModel = AuthViewModel();
  List<Widget> screens = [ContactScreen(), DashboardScreen(), SettingsScreen()];
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
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
                      authViewModel.auth.currentUser!.displayName ?? "",
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(width: 10,),
                    Icon(Icons.verified,color: Colors.deepOrange,)
                  ],
                ),
                accountEmail: Text(
                  authViewModel.auth.currentUser!.email ?? "",
                  style: TextStyle(color: Colors.black),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    authViewModel.auth.currentUser!.photoURL ??
                        "https://th.bing.com/th/id/OIP.yNEIwvAlvp4q71Mfj0NZaQHaHa?cb=iwc1&rs=1&pid=ImgDetMain",
                  ),
                ),
                decoration: BoxDecoration(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: OutlinedButton.icon(
                  label: Text("Logout"),
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
          actions: [
           IconButton(onPressed: (){
            Navigator.of(context).pushNamed("/ContactsSupportScreen");
           }, icon: Icon(Icons.support_agent,color: Colors.deepOrange,size: 40,))
          ],
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
                ),
                Icon(
                  Icons.manage_accounts_outlined,
                  color: Colors.black,
                  semanticLabel: 'Dashboard',
                ),
                Icon(
                  Icons.more_vert_outlined,
                  color: Colors.black,
                  semanticLabel: 'Settings',
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
