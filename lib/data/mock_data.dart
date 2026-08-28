import '../models/conversation.dart';
import '../models/job.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'repository.dart';
import 'seed_data.dart';

/// Point d'accès historique aux données simulées. Conservé pour compatibilité ;
/// tout délègue au [Repository] en mémoire.
class MockData {
  static List<User> get users => Seed.users.values.toList();
  static List<Post> get posts => Repository.instance.feed;
  static List<Job> get jobs => Repository.instance.jobs;
  static List<Conversation> get conversations =>
      Repository.instance.conversations;
}
