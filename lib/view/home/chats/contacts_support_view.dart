import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_visitor_admin/model/messages/message_model.dart';
import 'package:my_visitor_admin/view/home/chats/chat_view.dart';

class ContactsSupportScreen extends StatelessWidget {
  const ContactsSupportScreen({super.key});
  static String id = '/ContactsSupportScreen';
  Stream<List<MessageModel>> getUniqueUsernames() {
    return FirebaseFirestore.instance
        .collection('chat')
        .orderBy('createdAt', descending: true)
        // .where("sender",isNotEqualTo: "hoadel2003@gmail.com")
        .snapshots()
        .map((snapshot) {
          final uniqueUsernames = <String>{};
          return snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.data()))
              .where((message) => uniqueUsernames.add(message.userName))
              .toList();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chats")),
      body: StreamBuilder<List<MessageModel>>(
        stream: getUniqueUsernames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No contacts found"));
          }

          final messages = snapshot.data!;

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              // final username = usernames[index];
              final message = messages[index];

              return ContactsItem(messageModel: message);
            },
          );
        },
      ),
    );
  }
}

class ContactsItem extends StatelessWidget {
  const ContactsItem({super.key, required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ChatView.id,
          arguments: messageModel.sender,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 230, 232, 235),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 199, 180, 180),
              radius: 20,
              child: Icon(Icons.person_2_outlined),
            ),
            title: Text(
              messageModel.userName,
              style: TextStyle(
                color: Colors.black,
                fontSize: (22),
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              messageModel.message,
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepOrange),
          ),
        ),
      ),
    );
  }
}
