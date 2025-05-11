import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.password_outlined, color: Colors.deepOrange),
            title: Text("change password"),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.deepOrange,
            ),
            onTap: () => Navigator.of(context).pushNamed("/change-password"),
          ),
          Divider(),
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            activeTrackColor: Colors.deepOrange,
            activeColor: Colors.white,
            inactiveThumbColor: Colors.deepOrange,         
            title: Text("set darkeness"),
            subtitle: Text("you can switch on and of the button"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language, color: Colors.deepOrange),
            title: Text("choose application language"),
            subtitle: Text("you can drop and choose from the menu"),
            trailing: DropdownButton(
              underline: SizedBox(),
              value: "en",
              items: [
                DropdownMenuItem(value: "en", child: Text("en")),
                DropdownMenuItem(value: "ar", child: Text("ar")),
              ],
              onChanged: (value) {},
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
