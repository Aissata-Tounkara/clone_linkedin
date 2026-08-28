class NotificationModel {
  NotificationModel({
    required this.id,
    required this.text,
    required this.time,
    required this.userId,
    this.isRead = false,
  });
  final String id, text, time, userId;
  bool isRead;
}
