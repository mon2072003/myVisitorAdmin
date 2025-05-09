
import 'package:flutter/material.dart';
import 'package:my_visitor_admin/chat/data/models/message_model.dart';

class MyMessage extends StatelessWidget {
  final MessageModel messageModel;
  const MyMessage({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                  messageModel.message,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                getFormattedDateTime(createdAt: messageModel.createdAt)
                    .toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
String getFormattedDateTime({required DateTime createdAt}) {
  // Extract hour and minute from the provided DateTime
  int hour = createdAt.hour;
  int minute = createdAt.minute;

  // Determine if the time is PM and adjust hour for 12-hour format
  String period = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12;
  hour = hour == 0 ? 12 : hour; // Convert hour '0' to '12'

  // Format minute to ensure two digits
  String formattedMinute = minute.toString().padLeft(2, '0');

  // Return the formatted string
  return '$hour:$formattedMinute $period';
}

class FriendMessage extends StatelessWidget {
  final MessageModel messageModel;
  const FriendMessage({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: const Color(0xffEEEEEE),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Text(
                  messageModel.message,
                  style: const TextStyle(
                    color: Color.fromARGB(53, 0, 0, 0),
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                getFormattedDateTime(createdAt: messageModel.createdAt)
                    .toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
