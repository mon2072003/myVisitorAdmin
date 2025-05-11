import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/model/messages/message_model.dart';
import 'package:my_visitor_admin/view-model/home/chat_cubit/cubit_cubit/chat_cubit.dart';
import 'package:my_visitor_admin/widgets/chat_widgets/confirm_dialog.dart';
import 'package:my_visitor_admin/widgets/chat_widgets/messages_list_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChatViewBody extends StatefulWidget {
  final String contactEmail;

  const ChatViewBody({super.key, required this.contactEmail});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  final scrollController = ScrollController();
  final TextEditingController nameController = TextEditingController();

  TextEditingController textController = TextEditingController();
  final Stream<QuerySnapshot> chatStream =
      FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: false)
          .snapshots();
  @override
  void dispose() {
    scrollController.dispose();
    textController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  Future<void> _loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        nameController.text = data['name'] ?? '';
        setState(() {});
      }
    }
  }

  void sendMessage() async {
    final messageText = textController.text.trim();
    if (messageText.isNotEmpty) {
      await _loadUserData();
      BlocProvider.of<ChatCubit>(context).sendMEssage(
        messageModel: MessageModel(
          message: messageText,
          receiver: widget.contactEmail,
          sender: FirebaseAuth.instance.currentUser!.email!,
          userName: nameController.text,
          createdAt: DateTime.now(),
        ),
      );
      textController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void showConfirmDialog() {
    confiemDialog(
      context: context,
      type: AlertType.warning,
      title: '',
      description: 'are  you sure you want to leave the chat?',
      cancelOnPressed: () {
        Navigator.pop(context);
      },
      okOnPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!.email!;

    return StreamBuilder<QuerySnapshot>(
      stream: chatStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        // List<MessageModel> messagesList = snapshot.data?.docs
        //         .map((doc) => MessageModel.fromJson(doc))
        //         .toList() ??
        //     [];

        final messagesList =
            snapshot.data?.docs
                .map((doc) => MessageModel.fromJson(doc))
                .where(
                  (msg) =>
                      (msg.sender == currentUser &&
                          msg.receiver == widget.contactEmail) ||
                      (msg.sender == widget.contactEmail &&
                          msg.receiver == currentUser),
                )
                .toList() ??
            [];

        WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());

        return Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: MessagesListView(
                controller: scrollController,
                messagesList: messagesList,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textController,
                style: TextStyle(color: Colors.black),
                onSubmitted: (_) => sendMessage(),
                decoration: InputDecoration(
                  hintText: " Write message...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send, color: Colors.orange),
                    onPressed: sendMessage,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
