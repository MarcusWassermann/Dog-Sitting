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
              padding: const EdgeInsets.all(20.0), // Größere Innenpolsterung
              margin: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 20.0), // Größere Ränder
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius:
                    BorderRadius.circular(20.0), // Größere abgerundete Ecken
              ),
              child: Text(
                message,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0), // Größere Schriftgröße
              ),
            ),
          );
        },
      ),
    );
  }
}
