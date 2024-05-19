// chat_screen.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:dogs_sitting/chatpage/repository/chat_repository.dart';
import 'package:dogs_sitting/chatpage/widgets/message_input.dart';
import 'package:dogs_sitting/chatpage/widgets/message_list.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  final String chatPartnerName;

  const ChatScreen({super.key, required this.chatPartnerName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _messageController;
  late final ChatRepository _chatRepository;
  bool _isBlocked = false;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _chatRepository = ChatRepository();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _chatRepository.addMessage(_messageController.text.trim());
        _messageController.clear();
      });
    }
  }

  void _toggleBlockUser() {
    setState(() {
      _isBlocked = !_isBlocked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isBlocked ? 'Benutzer blockiert' : 'Benutzer entsperrt'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatPartnerName),
        actions: [
          IconButton(
            icon: Icon(_isBlocked ? Icons.block : Icons.block_flipped),
            onPressed: _toggleBlockUser,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Hintergrundbild über die gesamte Seite
          Positioned.fill(
            child: Image.asset(
              'assets/19296629.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Inhalte über das Hintergrundbild
          Column(
            children: [
              MessageList(
                messages: _chatRepository.messages,
                onDismissed: (index) {
                  setState(() {
                    _chatRepository.deleteMessage(index);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Nachricht gelöscht'),
                      action: SnackBarAction(
                        label: 'Rückgängig',
                        onPressed: () {
                          setState(() {
                            _chatRepository.restoreMessage(
                                index, _chatRepository.deletedMessages.last);
                          });
                        },
                      ),
                    ),
                  );
                },
                onRestore: (index, message) {
                  setState(() {
                    _chatRepository.restoreMessage(index, message);
                  });
                },
              ),
              _isBlocked
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Sie haben diesen Benutzer blockiert. Sie können keine Nachrichten senden oder empfangen.',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : MessageInput(
                      messageController: _messageController,
                      onSendMessage: _sendMessage,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
