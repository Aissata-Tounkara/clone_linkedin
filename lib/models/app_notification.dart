class AppNotification {
  AppNotification({
    required this.text,
    required this.time,
    required this.initials,
    required this.colorValue,
    this.read = false,
  });
  final String text, time, initials;
  final int colorValue;
  bool read;
}
