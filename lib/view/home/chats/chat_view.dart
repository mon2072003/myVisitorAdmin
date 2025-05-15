import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/view-model/home/chat_cubit/cubit_cubit/chat_cubit.dart';
import 'package:my_visitor_admin/widgets/chat_widgets/chat_view_body.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.contactEmail});
  static const String id = 'ChatView';
  final String contactEmail;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          title: Text(
            contactEmail,
            style: style22Gray(context),
          ),
        ),
        body: ChatViewBody(contactEmail: contactEmail),
      ),
    );
  }
}

TextStyle style22Gray(BuildContext context) {
  return const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Color(0xffBDBDBD),
  );
}
