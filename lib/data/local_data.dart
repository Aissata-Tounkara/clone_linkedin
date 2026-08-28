import '../models/app_notification.dart';
import '../models/conversation.dart';
import '../models/job.dart';
import '../models/post.dart';
import '../models/search_item.dart';
import 'repository.dart';

/// Couche de compatibilité : les anciens écrans lisent encore `LocalData.*`.
/// Tout délègue désormais au [Repository] en mémoire.
class LocalData {
  static List<Post> get posts => Repository.instance.feed;
  static List<Job> get jobs => Repository.instance.jobs;
  static List<AppNotification> get notifications =>
      Repository.instance.notifications;
  static List<Conversation> get conversations =>
      Repository.instance.conversations;

  static const searchItems = <SearchItem>[
    SearchItem(
      category: SearchCategory.people,
      title: 'Sophie Martin',
      subtitle: 'Développeuse Flutter · Nova Labs · Paris',
      initials: 'SM',
      colorValue: 0xFF7C3AED,
    ),
    SearchItem(
      category: SearchCategory.people,
      title: 'Karim Benali',
      subtitle: 'Product Designer · Studio Kanata · Lyon',
      initials: 'KB',
      colorValue: 0xFF0369A1,
    ),
    SearchItem(
      category: SearchCategory.companies,
      title: 'Nova Labs',
      subtitle: 'Développement d’applications mobiles · 51-200 employés',
      initials: 'NL',
      colorValue: 0xFF2563EB,
    ),
    SearchItem(
      category: SearchCategory.jobs,
      title: 'Développeur·se Flutter',
      subtitle: 'Nova Labs · Paris · Hybride · Il y a 2 jours',
      initials: 'NL',
      colorValue: 0xFF166534,
    ),
    SearchItem(
      category: SearchCategory.posts,
      title: 'Les animations Flutter qui font la différence',
      subtitle: 'Publication de Sophie Martin',
      initials: 'SM',
      colorValue: 0xFF7C3AED,
    ),
  ];
}
