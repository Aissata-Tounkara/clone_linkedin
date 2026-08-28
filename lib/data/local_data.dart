import '../models/post.dart';
import '../models/search_item.dart';
import '../models/job.dart';
import '../models/app_notification.dart';
import '../models/conversation.dart';

class LocalData {
  static final posts = <Post>[
    Post(
      id: 'flutter-team',
      author: 'Sophie Martin',
      role: 'Développeuse Flutter · 2 h',
      initials: 'SM',
      colorValue: 0xFF7C3AED,
      time: '2 h',
      content:
          'Très heureuse de partager notre nouveau guide sur les animations Flutter. Les petits détails rendent une expérience mémorable.',
      likes: 128,
      comments: 18,
      visualLabel: 'Flutter\nDesign system',
    ),
    Post(
      id: 'remote-work',
      author: 'Karim Benali',
      role: 'Product Designer · 4 h',
      initials: 'KB',
      colorValue: 0xFF0F766E,
      time: '4 h',
      content:
          'Une bonne équipe ne travaille pas seulement ensemble : elle prend aussi le temps de célébrer les progrès de chacun.',
      likes: 86,
      comments: 9,
    ),
    Post(
      id: 'career',
      author: 'Nadia Tech',
      role: 'Recruteuse tech · 1 j',
      initials: 'NT',
      colorValue: 0xFFB45309,
      time: '1 j',
      content:
          'Nous recherchons un(e) développeur(se) Flutter pour rejoindre une équipe produit bienveillante et ambitieuse.',
      likes: 241,
      comments: 34,
      visualLabel: 'Une équipe,\ndes idées,\ndu mouvement.',
    ),
  ];
  static const searchItems = <SearchItem>[
    SearchItem(
      category: SearchCategory.people,
      title: 'Sophie Martin',
      subtitle: 'Développeuse Flutter · Paris',
      initials: 'SM',
      colorValue: 0xFF7C3AED,
    ),
    SearchItem(
      category: SearchCategory.people,
      title: 'Amine Flutter',
      subtitle: 'Mobile engineer · Alger',
      initials: 'AF',
      colorValue: 0xFF0369A1,
    ),
    SearchItem(
      category: SearchCategory.companies,
      title: 'Flutter Studio',
      subtitle: 'Développement d’applications mobiles',
      initials: 'FS',
      colorValue: 0xFF2563EB,
    ),
    SearchItem(
      category: SearchCategory.jobs,
      title: 'Développeur Flutter',
      subtitle: 'Nova Labs · Hybride · Il y a 2 jours',
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

  static const jobs = <Job>[
    Job(
      title: 'Flutter Developer',
      company: 'Nova Labs',
      location: 'Alger · Hybride',
      type: 'CDI',
      initials: 'NL',
      colorValue: 0xFF0A66C2,
    ),
    Job(
      title: 'Full Stack Developer',
      company: 'Atelier Digital',
      location: 'Paris · À distance',
      type: 'CDI',
      initials: 'AD',
      colorValue: 0xFF7C3AED,
    ),
    Job(
      title: 'Laravel Developer',
      company: 'Pixel & Co',
      location: 'Oran · Sur site',
      type: 'Freelance',
      initials: 'PC',
      colorValue: 0xFFB45309,
    ),
    Job(
      title: 'React Developer',
      company: 'Cloudline',
      location: 'Lyon · Hybride',
      type: 'CDI',
      initials: 'CL',
      colorValue: 0xFF0F766E,
    ),
    Job(
      title: 'Mobile Developer',
      company: 'Motion Apps',
      location: 'Tunis · À distance',
      type: 'Stage',
      initials: 'MA',
      colorValue: 0xFFE16745,
    ),
  ];

  static final notifications = <AppNotification>[
    AppNotification(
      text: 'Sophie Martin a aimé votre publication.',
      time: 'Il y a 12 min',
      initials: 'SM',
      colorValue: 0xFF7C3AED,
    ),
    AppNotification(
      text: 'Karim Benali a commenté votre publication.',
      time: 'Il y a 1 h',
      initials: 'KB',
      colorValue: 0xFF0F766E,
    ),
    AppNotification(
      text: 'Nadia Tech vous a envoyé une invitation.',
      time: 'Il y a 3 h',
      initials: 'NT',
      colorValue: 0xFFB45309,
    ),
    AppNotification(
      text: 'Une nouvelle offre Flutter Developer correspond à votre profil.',
      time: 'Hier',
      initials: 'NL',
      colorValue: 0xFF0A66C2,
      read: true,
    ),
    AppNotification(
      text: 'Amine Flutter a consulté votre profil.',
      time: 'Hier',
      initials: 'AF',
      colorValue: 0xFF0369A1,
      read: true,
    ),
  ];

  static final conversations = <Conversation>[
    Conversation(
      name: 'Sophie Martin',
      initials: 'SM',
      colorValue: 0xFF7C3AED,
      time: '10:24',
      unread: 2,
      messages: [
        ChatMessage(
          text: 'Bonjour ! As-tu vu le guide Flutter ?',
          mine: false,
          time: '10:20',
        ),
        ChatMessage(
          text: 'Oui, il est vraiment très clair.',
          mine: true,
          time: '10:22',
        ),
      ],
    ),
    Conversation(
      name: 'Karim Benali',
      initials: 'KB',
      colorValue: 0xFF0F766E,
      time: 'Hier',
      messages: [
        ChatMessage(
          text: 'Merci pour ton retour sur la maquette.',
          mine: false,
          time: 'Hier',
        ),
      ],
    ),
    Conversation(
      name: 'Nadia Tech',
      initials: 'NT',
      colorValue: 0xFFB45309,
      time: 'Lun.',
      unread: 1,
      messages: [
        ChatMessage(
          text: 'Notre équipe souhaite échanger avec vous.',
          mine: false,
          time: 'Lun.',
        ),
      ],
    ),
  ];
}
