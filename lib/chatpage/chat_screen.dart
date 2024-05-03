import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildMessage(isMe: false, message: 'Hallo! Wie geht es dir?'),
                _buildMessage(
                    isMe: true, message: 'Hallo! Mir geht es gut, danke!'),
                _buildMessage(isMe: false, message: 'Das freut mich zu hören!'),
                _buildMessage(isMe: true, message: 'Ja, danke!'),
                _buildMessage(isMe: false, message: 'Was machst du gerade?'),
              ],
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessage({required bool isMe, required String message}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            message,
            style: TextStyle(color: isMe ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Nachricht eingeben...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          IconButton(
            onPressed: () {
              // Send message functionality
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

