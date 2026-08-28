/// Commentaire sur une publication. `replies` gère un seul niveau
/// d'imbrication, comme sur LinkedIn.
class Comment {
  Comment({
    required this.id,
    required this.authorId,
    required this.text,
    required this.time,
    this.postId = '',
    this.likes = 0,
    this.liked = false,
    this.isAuthor = false,
    List<Comment>? replies,
  }) : replies = replies ?? [];

  final String id, authorId, text, time, postId;
  int likes;
  bool liked;
  final bool isAuthor;
  final List<Comment> replies;
}
