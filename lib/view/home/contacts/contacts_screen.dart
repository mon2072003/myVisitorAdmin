import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/view-model/home/contacts_cubit/contacts_cubit.dart';
import 'package:my_visitor_admin/view/home/contacts/contact_info/contact_info.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsCubit(),
      child: Scaffold(
        body: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (context, state) {
            BlocProvider.of<ContactsCubit>(context).getContacts();
            if (state is ContactsInitial) {
              return Center(
                child: CircularProgressIndicator(color: Colors.deepOrange),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        state.contacts[index].profileImageUrl!,
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
                    title: Text(state.contacts[index].name!),
                    subtitle: Text(state.contacts[index].email!),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      color: Colors.deepOrange,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ContactInfo(
                                  contacts: state.contacts[index],
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
