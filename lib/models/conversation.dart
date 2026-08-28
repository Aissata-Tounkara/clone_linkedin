class ChatMessage {
  ChatMessage({
    required this.text,
    required this.mine,
    required this.time,
    this.day = "Aujourd'hui",
    this.status = 'Envoyé',
  });
  final String text, time, day;
  final bool mine;
  final String status;
}

class Conversation {
  Conversation({
    required this.id,
    required this.name,
    required this.time,
    required this.messages,
    this.initials = '',
    this.colorValue = 0xFF0A66C2,
    this.headline = '',
    this.authorId = '',
    this.online = false,
    this.unread = 0,
  });
  final String id, name, time, initials, headline, authorId;
  final int colorValue;
  bool online;
  int unread;
  final List<ChatMessage> messages;

  String get preview => messages.isEmpty
      ? ''
      : (messages.last.mine ? 'Vous : ' : '') + messages.last.text;

  String get seed => authorId.isEmpty ? 'conv:$id' : 'u:$authorId';
}
