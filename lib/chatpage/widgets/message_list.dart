// widgets/message_list.dart

import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  final List<String> messages;
  final void Function(int) onDismissed;
  final void Function(int, String) onRestore;

  const MessageList({
    super.key,
    required this.messages,
    required this.onDismissed,
    required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return Dismissible(
            key: Key(message),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => onDismissed(index),
            background: Container(color: Colors.red),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
