import '../theme/app_tokens.dart';
import 'comment.dart';

enum PostMedia { none, image, article, document, poll }

class PollOption {
  PollOption(this.label, this.votes);
  final String label;
  int votes;
}

class Post {
  Post({
    required this.id,
    required this.author,
    required this.role,
    required this.time,
    required this.content,
    this.authorId = '',
    this.initials = '',
    this.colorValue = 0xFF0A66C2,
    this.likes = 0,
    this.comments = 0,
    this.reposts = 0,
    this.visualLabel,
    this.liked = false,
    this.media = PostMedia.none,
    this.imageSeed,
    this.articleTitle,
    this.articleDomain,
    this.documentTitle,
    this.documentPages,
    List<PollOption>? pollOptions,
    this.myReaction,
    Map<LiReaction, int>? reactions,
    List<Comment>? commentList,
    this.isConnection = true,
    this.following = false,
  }) : pollOptions = pollOptions ?? [],
       reactions = reactions ?? {},
       commentList = commentList ?? [];

  final String id, author, role, time, content;
  final String authorId, initials;
  final int colorValue;
  final int likes;
  int comments;
  final int reposts;
  final String? visualLabel;
  bool liked;

  final PostMedia media;
  final String? imageSeed;
  final String? articleTitle;
  final String? articleDomain;
  final String? documentTitle;
  final int? documentPages;
  final List<PollOption> pollOptions;

  /// Réaction de l'utilisateur courant (null = aucune).
  LiReaction? myReaction;

  /// Décompte par type de réaction (preuve sociale).
  final Map<LiReaction, int> reactions;
  final List<Comment> commentList;

  final bool isConnection;
  bool following;

  int get totalReactions =>
      reactions.values.fold(0, (a, b) => a + b) + (myReaction != null ? 1 : 0);

  String get seed => authorId.isEmpty ? 'p:$id' : 'u:$authorId';

  /// Les 3 types de réactions les plus fréquents, pour la pile d'emojis.
  List<LiReaction> get topReactions {
    final entries = reactions.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final list = entries.map((e) => e.key).toList();
    if (myReaction != null && !list.contains(myReaction)) {
      list.insert(0, myReaction!);
    }
    return list.take(3).toList();
  }
}
