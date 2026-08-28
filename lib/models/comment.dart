class Comment {
  const Comment({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.text,
    required this.time,
  });
  final String id, postId, authorId, text, time;
}
