enum NotifType { reaction, comment, connection, job, post, mention, birthday }

class AppNotification {
  AppNotification({
    required this.text,
    required this.time,
    this.initials = '',
    this.colorValue = 0xFF0A66C2,
    this.read = false,
    this.type = NotifType.post,
    this.actorId = '',
    this.actorName = '',
    this.cta,
  });

  final String text, time, initials, actorId, actorName;
  final int colorValue;
  bool read;
  final NotifType type;

  /// Libellé du bouton d'action (ex. « Voir », « Répondre »), ou null.
  final String? cta;

  String get seed => actorId.isEmpty ? 'n:$text' : 'u:$actorId';
}
