import 'dart:async';
import 'package:flutter/foundation.dart';

import '../models/app_notification.dart';
import '../models/comment.dart';
import '../models/conversation.dart';
import '../models/job.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../state/current_user.dart';
import '../theme/app_tokens.dart';
import 'gen.dart';
import 'seed_data.dart';

/// Source de vérité unique, entièrement en mémoire. Les écrans écoutent ce
/// [ChangeNotifier] ; toute action (like, commentaire, invitation acceptée,
/// message envoyé…) se propage partout.
class Repository extends ChangeNotifier {
  Repository._() {
    _posts.addAll(Seed.posts());
    _invitations.addAll(Seed.invitationIds().map(Seed.user));
    _suggestions.addAll(Seed.suggestionIds().map(Seed.user));
    _notifications.addAll(Seed.notifications());
    _conversations.addAll(Seed.conversations());
    _jobs.addAll(Seed.jobs());
  }

  static final Repository instance = Repository._();

  // --- Profil courant ---------------------------------------------------

  String get myName {
    final n = CurrentUser.profile.value.displayName;
    return n.isEmpty ? 'Vous' : n;
  }

  String get mySeed => 'me:$myName';

  User get me => User(
    id: 'me',
    name: myName,
    headline: CurrentUser.profile.value.headline.isEmpty
        ? 'Membre LinkedIn'
        : CurrentUser.profile.value.headline,
    degree: '',
    location: CurrentUser.profile.value.location,
    about: CurrentUser.profile.value.about,
    connectionsCount: _relationsCount,
    profileViews: 142,
    searchAppearances: 27,
    followers: 318,
    experiences: const [
      Experience(
        role: 'Développeur·se full-stack',
        company: 'Freelance',
        period: '2023 - aujourd’hui',
        location: 'À distance',
        description: 'Web et mobile · React, Node.js, Flutter.',
      ),
    ],
    educations: const [
      Education(
        school: 'Institut Supérieur de Technologie',
        degree: 'Licence professionnelle en génie informatique',
        period: '2019 - 2022',
      ),
    ],
    skills: const ['Flutter', 'Dart', 'React', 'Node.js', 'Git', 'UI Design'],
  );

  void updateProfile({
    String? firstName,
    String? lastName,
    String? headline,
    String? about,
    String? location,
  }) {
    CurrentUser.update(
      firstName: firstName ?? CurrentUser.profile.value.firstName,
      lastName: lastName ?? CurrentUser.profile.value.lastName,
      headline: headline ?? CurrentUser.profile.value.headline,
      about: about ?? CurrentUser.profile.value.about,
      location: location ?? CurrentUser.profile.value.location,
    );
    notifyListeners();
  }

  // --- Feed -----------------------------------------------------------

  final List<Post> _posts = [];
  int _genOffset = 0;
  List<Post> get feed => List.unmodifiable(_posts);

  List<Post> postsBy(String authorId) =>
      _posts.where((p) => p.authorId == authorId).toList();

  Post? postById(String id) {
    for (final p in _posts) {
      if (p.id == id) return p;
    }
    return null;
  }

  void addPost(String content, {String? imageSeed}) {
    _posts.insert(
      0,
      Post(
        id: 'me-${DateTime.now().microsecondsSinceEpoch}',
        authorId: 'me',
        author: myName,
        role: me.headline,
        time: 'À l’instant',
        content: content,
        likes: 0,
        comments: 0,
        media: imageSeed != null ? PostMedia.image : PostMedia.none,
        imageSeed: imageSeed,
      ),
    );
    notifyListeners();
  }

  void toggleReaction(Post post, LiReaction reaction) {
    if (post.myReaction == reaction) {
      post.myReaction = null;
    } else {
      post.myReaction = reaction;
    }
    notifyListeners();
  }

  void toggleFollow(Post post) {
    post.following = !post.following;
    notifyListeners();
  }

  void votePoll(Post post, int optionIndex) {
    if (post.media != PostMedia.poll) return;
    post.pollOptions[optionIndex].votes++;
    notifyListeners();
  }

  Comment addComment(Post post, String text, {Comment? parent}) {
    final c = Comment(
      id: 'mc-${DateTime.now().microsecondsSinceEpoch}',
      authorId: 'me',
      text: text,
      time: 'À l’instant',
    );
    if (parent != null) {
      parent.replies.add(c);
    } else {
      post.commentList.add(c);
    }
    post.comments++;
    notifyListeners();
    return c;
  }

  void toggleCommentLike(Comment c) {
    c.liked = !c.liked;
    c.likes += c.liked ? 1 : -1;
    notifyListeners();
  }

  List<Post> loadMore({int count = 5}) {
    final more = moreFeedPosts(_genOffset, count);
    _genOffset += count;
    _posts.addAll(more);
    notifyListeners();
    return more;
  }

  // --- Réseau -------------------------------------------------------

  final List<User> _invitations = [];
  final List<User> _suggestions = [];
  int _relationsCount = 517;

  List<User> get invitations => List.unmodifiable(_invitations);
  List<User> get suggestions => List.unmodifiable(_suggestions);
  int get pendingInvitations => _invitations.length;
  int get relationsCount => _relationsCount;

  void acceptInvitation(User user) {
    _invitations.removeWhere((u) => u.id == user.id);
    _relationsCount++;
    _ensureConversation(user, greeting: true);
    notifyListeners();
  }

  void ignoreInvitation(User user) {
    _invitations.removeWhere((u) => u.id == user.id);
    notifyListeners();
  }

  void connect(User user) {
    _suggestions.removeWhere((u) => u.id == user.id);
    notifyListeners();
  }

  void dismissSuggestion(User user) {
    _suggestions.removeWhere((u) => u.id == user.id);
    notifyListeners();
  }

  // --- Notifications ---------------------------------------------

  final List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => List.unmodifiable(_notifications);
  int get unreadNotifications =>
      _notifications.where((n) => !n.read).length;

  void markNotificationRead(AppNotification n) {
    n.read = true;
    notifyListeners();
  }

  void markAllNotificationsRead() {
    for (final n in _notifications) {
      n.read = true;
    }
    notifyListeners();
  }

  // --- Messagerie ----------------------------------------------

  final List<Conversation> _conversations = [];
  List<Conversation> get conversations => List.unmodifiable(_conversations);
  int get unreadMessages =>
      _conversations.fold(0, (sum, c) => sum + c.unread);

  Conversation? conversationById(String id) {
    for (final c in _conversations) {
      if (c.id == id) return c;
    }
    return null;
  }

  Conversation _ensureConversation(User user, {bool greeting = false}) {
    final existing = _conversations
        .where((c) => c.authorId == user.id)
        .firstOrNull;
    if (existing != null) return existing;
    final conv = Conversation(
      id: 'conv-${user.id}',
      authorId: user.id,
      name: user.name,
      headline: user.headline,
      time: 'À l’instant',
      messages: [
        if (greeting)
          ChatMessage(
            text: 'Merci pour la mise en relation ! Ravi·e d’échanger.',
            mine: false,
            time: 'À l’instant',
          ),
      ],
    );
    _conversations.insert(0, conv);
    return conv;
  }

  Conversation openConversationWith(User user) {
    final conv = _ensureConversation(user);
    notifyListeners();
    return conv;
  }

  void markConversationRead(Conversation conv) {
    if (conv.unread != 0) {
      conv.unread = 0;
      notifyListeners();
    }
  }

  void sendMessage(Conversation conv, String text) {
    conv.messages.add(
      ChatMessage(text: text, mine: true, time: 'À l’instant', status: 'Envoyé'),
    );
    notifyListeners();
    // Réponse automatique scriptée pour « donner vie » à la conversation.
    Timer(const Duration(milliseconds: 1400), () {
      conv.online = true;
      conv.messages.add(
        ChatMessage(
          text: _autoReply(text),
          mine: false,
          time: 'À l’instant',
        ),
      );
      notifyListeners();
    });
  }

  String _autoReply(String toText) {
    final t = toText.toLowerCase();
    if (t.contains('?')) return 'Bonne question — laisse-moi vérifier et je te redis.';
    if (t.contains('merci')) return 'Avec plaisir 🙌';
    if (t.contains('bonjour') || t.contains('salut')) {
      return 'Bonjour ! Comment puis-je aider ?';
    }
    return 'Bien reçu, merci pour ton message !';
  }

  // --- Emplois -----------------------------------------------

  final List<Job> _jobs = [];
  List<Job> get jobs => List.unmodifiable(_jobs);
  List<Job> get savedJobs => _jobs.where((j) => j.saved).toList();
  List<Job> get appliedJobs => _jobs.where((j) => j.applied).toList();

  Job? jobById(String id) {
    for (final j in _jobs) {
      if (j.id == id) return j;
    }
    return null;
  }

  void toggleSaveJob(Job job) {
    job.saved = !job.saved;
    notifyListeners();
  }

  void applyToJob(Job job) {
    job.applied = true;
    notifyListeners();
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
