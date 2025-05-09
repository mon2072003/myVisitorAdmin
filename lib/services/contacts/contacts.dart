import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_visitor_admin/model/contacts/contacts_model.dart';

class ContactsAPI {
List<ContactsModel> users = [];

Future<List<ContactsModel>> getContacts() async {
  final firestore = FirebaseFirestore.instance;
  final usersCollection = firestore.collection('users');
  try {
    final querySnapshot = await usersCollection.get();
    users = querySnapshot.docs.map((doc) => ContactsModel.fromList(doc.data())).toList();
  } catch (e) {
    debugPrint('Error fetching users: $e');
  }
return users;
}

}