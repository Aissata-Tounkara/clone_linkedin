class ChatMessage {
  ChatMessage({required this.text, required this.mine, required this.time});
  final String text, time;
  final bool mine;
}

class Conversation {
  Conversation({
    required this.name,
    required this.initials,
    required this.colorValue,
    required this.time,
    required this.messages,
    this.unread = 0,
  });
  final String name, initials, time;
  final int colorValue;
  int unread;
  final List<ChatMessage> messages;
  String get preview => messages.isEmpty ? '' : messages.last.text;
}
