import '../models/comment.dart';
import '../models/message.dart';
import '../models/user.dart';
import 'local_data.dart';

/// Point d'accès unique aux données simulées de l'application.
class MockData {
  static const users = <User>[
    User(
      id: 'aissata',
      name: 'Aïssata Tounkara',
      headline: 'Développeuse Flutter · Mobile & UI',
      initials: 'AT',
      colorValue: 0xFF0A66C2,
      location: 'Alger, Algérie',
    ),
    User(
      id: 'sophie',
      name: 'Sophie Martin',
      headline: 'Développeuse Flutter',
      initials: 'SM',
      colorValue: 0xFF7C3AED,
      location: 'Paris, France',
    ),
  ];
  static final posts = LocalData.posts;
  static const jobs = LocalData.jobs;
  static final notifications = LocalData.notifications;
  static final conversations = LocalData.conversations;
  static const messages = <Message>[
    Message(id: 'm1', text: 'Bonjour !', sentAt: '10:20', isMine: false),
  ];
  static const comments = <Comment>[
    Comment(
      id: 'c1',
      postId: 'flutter-team',
      authorId: 'aissata',
      text: 'Très belle initiative !',
      time: 'Il y a 1 h',
    ),
  ];
}
