
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_visitor_admin/model/messages/message_model.dart';
import 'package:my_visitor_admin/widgets/chat_widgets/message_view.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView(
      {super.key, required this.controller, required this.messagesList});
  final ScrollController controller;
  final List<MessageModel> messagesList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messagesList.length,
        controller: controller,
        itemBuilder: (context, index) {
          return messagesList[index].sender ==
                  FirebaseAuth.instance.currentUser!.email!
              ? MyMessage(
                  messageModel: messagesList[index],
                )
              : FriendMessage(
                  messageModel: messagesList[index],
                );
        });
  }
}
