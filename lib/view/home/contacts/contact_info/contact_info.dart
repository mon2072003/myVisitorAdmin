import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_visitor_admin/model/contacts/contacts_model.dart';

class ContactInfo extends StatelessWidget {
  ContactsModel contacts;
  ContactInfo({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                contacts.profileImageUrl!,
                fit: BoxFit.fill,
                errorBuilder:
                    (context, error, stackTrace) => LottieBuilder.asset(
                      'images/egypt.json',
                      fit: BoxFit.fill,
                      backgroundLoading: true,
                      repeat: true,
                    ),
              ),
            ),
          ),
          SliverList(
            
            delegate: SliverChildListDelegate([
              ListTile(
                leading: Icon(Icons.person, color: Colors.deepOrange),
                title: Text(contacts.name!),
              ),
              ListTile(
                leading: Icon(Icons.email, color: Colors.deepOrange),
                title: Text(contacts.email!),
              ),
              ListTile(
                leading: Icon(Icons.phone, color: Colors.deepOrange),
                title: Text(contacts.phoneNumber!),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  label: Text("Send Message"),
                  icon: Icon(Icons.message),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
