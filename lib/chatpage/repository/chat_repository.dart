import 'package:shared_preferences/shared_preferences.dart';

class ChatRepository {
  final List<String> _messages = [];
  final List<String> _deletedMessages = [];
  final String _messagesKey = 'messages';

  List<String> get messages => List.unmodifiable(_messages);
  List<String> get deletedMessages => List.unmodifiable(_deletedMessages);

  Future<void> addMessage(String message) async {
    _messages.add(message);
    await saveMessages();
  }

  Future<void> deleteMessage(int index) async {
    if (index >= 0 && index < _messages.length) {
      _deletedMessages.add(_messages[index]);
      _messages.removeAt(index);
      await saveMessages();
    }
  }

  Future<void> restoreMessage(int index, String message) async {
    _messages.insert(index, message);
    _deletedMessages.remove(message);
    await saveMessages();
  }

  Future<void> saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_messagesKey, _messages);
  }

  Future<void> loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedMessages = prefs.getStringList(_messagesKey);
    if (storedMessages != null) {
      _messages.clear();
      _messages.addAll(storedMessages);
    }
  }

  Future<void> clearMessages() async {
    _messages.clear();
    await saveMessages();
  }
}
