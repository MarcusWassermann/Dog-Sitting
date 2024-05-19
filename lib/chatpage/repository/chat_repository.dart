// repositories/chat_repository.dart

class ChatRepository {
  final List<String> _messages = [];
  final List<String> _deletedMessages = [];

  List<String> get messages => List.unmodifiable(_messages);
  List<String> get deletedMessages => List.unmodifiable(_deletedMessages);

  void addMessage(String message) {
    _messages.add(message);
  }

  void deleteMessage(int index) {
    _deletedMessages.add(_messages[index]);
    _messages.removeAt(index);
  }

  void restoreMessage(int index, String message) {
    _messages.insert(index, message);
    _deletedMessages.remove(message);
  }
}
