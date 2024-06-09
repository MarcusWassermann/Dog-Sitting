import 'package:flutter/material.dart';
import 'package:dogs_sitting/chatpage/repository/chat_repository.dart';
import 'package:dogs_sitting/chatpage/widgets/message_input.dart';
import 'package:dogs_sitting/chatpage/widgets/message_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final TextEditingController _messageController;
  late final ChatRepository _chatRepository;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _chatRepository = ChatRepository();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    await _chatRepository.loadMessages();
    setState(() {});
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

  void _deleteMessage(int index) async {
    await _chatRepository.deleteMessage(index);
    setState(() {});
  }

  void _restoreMessage(int index, String message) async {
    await _chatRepository.restoreMessage(index, message);
    setState(() {});
  }

  void _clearChat() async {
    await _chatRepository.clearMessages();
    setState(() {});
  }

  void _blockUser(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Benutzer blockieren'),
          content:
              const Text('Möchtest du diesen Benutzer wirklich blockieren?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () {
                // Hier kannst du die Logik implementieren, um den Benutzer zu blockieren
                Navigator.pop(context);
              },
              child: const Text('Blockieren'),
            ),
          ],
        );
      },
    );
  }

  void _deleteChat(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chat löschen'),
          content: const Text('Möchtest du diesen Chat wirklich löschen?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () {
                _clearChat();
                Navigator.pop(context);
              },
              child: const Text('Löschen'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Chat')), // Titel zentriert
        backgroundColor: Colors.grey[200], // Leichtes Grau als Hintergrundfarbe
        actions: [
          IconButton(
            onPressed: () => _deleteChat(context),
            icon: const Icon(Icons.delete),
            color: Colors.black, // Schwarze Farbe für das Icon
          ),
          IconButton(
            onPressed: () => _blockUser(context),
            icon: const Icon(Icons.block),
            color: Colors.black, // Schwarze Farbe für das Icon
          ),
        ],
      ),
      backgroundColor: Colors.grey[200], // Leichtes Grau als Hintergrundfarbe
      body: Container(
        color: Colors.grey[200], // Leichtes Grau als Hintergrundfarbe
        child: Column(
          children: [
            Expanded(
              child: MessageList(
                messages: _chatRepository.messages,
                onDismissed: _deleteMessage,
                onRestore: _restoreMessage,
              ),
            ),
            MessageInput(
              messageController: _messageController,
              onSendMessage: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
