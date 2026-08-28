class Post {
  Post({
    required this.id,
    required this.author,
    required this.role,
    required this.initials,
    required this.colorValue,
    required this.time,
    required this.content,
    required this.likes,
    required this.comments,
    this.visualLabel,
    this.liked = false,
  });
  final String id, author, role, initials, time, content;
  final int colorValue, likes;
  int comments;
  final String? visualLabel;
  bool liked;
}
