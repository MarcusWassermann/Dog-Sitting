// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatPartnerName;
  const ChatScreen({super.key,required this.chatPartnerName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _messageController;
  final List<String> _messages = [];
  final List<String> _deletedMessages = [];
  bool _isBlocked = false;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
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
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return Dismissible(
                      key: Key(message),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          _deletedMessages.add(message);
                          _messages.removeAt(index);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Nachricht gelöscht'),
                            action: SnackBarAction(
                              label: 'Rückgängig',
                              onPressed: () {
                                setState(() {
                                  _messages.insert(index, message);
                                  _deletedMessages.remove(message);
                                });
                              },
                            ),
                          ),
                        );
                      },
                      background: Container(color: Colors.red),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
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
              ),
              _isBlocked
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Sie haben diesen Benutzer blockiert. Sie können keine Nachrichten senden oder empfangen.',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : _buildMessageInput(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Nachricht schreiben...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text.trim());
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
}
