import 'package:flutter/material.dart';
import 'package:my_visitor_admin/model/contacts/contacts_model.dart';
import 'package:my_visitor_admin/view/home/contacts/contact_info/contact_info.dart';

class SearchContactsDelegate extends SearchDelegate<String> {
  final List<ContactsModel> contacts;

  SearchContactsDelegate({required this.contacts});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results =
        contacts
            .where(
              (contact) =>
                  contact.email!.toLowerCase().contains(query.toLowerCase()) ||
                  contact.name!.toLowerCase().contains(query.toLowerCase())||
                  contact.phoneNumber!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              results[index].profileImageUrl!,
              fit: BoxFit.fill,
              width: 40,
              height: 40,
              errorBuilder:
                  (context, error, stackTrace) => const Icon(
                    Icons.account_circle_outlined,
                    size: 40,
                    color: Colors.deepOrange,
                  ),
            ),
          ),
          title: Text(results[index].name!),
          subtitle: Text(results[index].email!),
          trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactInfo(
                    contacts: results[index],
                  ),
                ),
              );
            },
            icon: Icon(Icons.arrow_forward_ios, color: Colors.deepOrange),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox();
  }
}
