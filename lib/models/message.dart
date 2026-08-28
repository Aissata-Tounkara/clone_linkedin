class Message {
  const Message({
    required this.id,
    required this.text,
    required this.sentAt,
    required this.isMine,
  });
  final String id, text, sentAt;
  final bool isMine;
}
