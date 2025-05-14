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
      users =
          querySnapshot.docs
              .map((doc) => ContactsModel.fromList(doc.data()))
              .toList();
    } catch (e) {
      debugPrint('Error fetching users: $e');
    }
    return users;
  }

  static Future<ContactsModel?> getCurrentUserByEmail(String email) async {
    final firestore = FirebaseFirestore.instance;
    final usersCollection = firestore.collection('users');
    try {
      final querySnapshot =
          await usersCollection.where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        return ContactsModel.fromList(querySnapshot.docs.first.data());
      }
    } catch (e) {
      debugPrint('Error fetching user by email: $e');
    }
    return ContactsModel(
      email: '',
      name: '',
      phoneNumber: '',
      profileImageUrl: 'assets/images/defualt_profile.png',
    );
  }
}
