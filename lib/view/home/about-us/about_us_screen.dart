import 'package:flutter/material.dart';
import 'package:my_visitor_admin/generated/l10n.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).about_us),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.travel_explore, size: 80, color: Colors.deepOrange),
            SizedBox(height: 20),
            Text(
              "This application is dedicated to promoting Egyptian tourism.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Developed by a passionate team, it aims to showcase the beauty, history, and culture of Egypt to the world.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history, size: 40, color: Colors.deepOrange),
                SizedBox(width: 10),
                Icon(Icons.account_balance, size: 40, color: Colors.deepOrange),
                SizedBox(width: 10),
                Icon(Icons.nature_people, size: 40, color: Colors.deepOrange),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
