import '../models/app_notification.dart';
import '../models/comment.dart';
import '../models/conversation.dart';
import '../models/job.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../theme/app_tokens.dart';

/// Jeu de données initial, cohérent entre écrans (les auteurs de posts,
/// d'invitations, de conversations et de notifications partagent les mêmes
/// identifiants). Tout est en mémoire.
class Seed {
  static final users = <String, User>{
    for (final u in _users) u.id: u,
  };

  static User user(String id) =>
      users[id] ??
      User(id: id, name: id, headline: 'Membre LinkedIn', degree: '2e');

  static final List<User> _users = [
    const User(
      id: 'sophie',
      name: 'Sophie Martin',
      headline: 'Développeuse Flutter · Mobile & Design system chez Nova Labs',
      location: 'Paris, France',
      degree: '1er',
      mutuals: 14,
      company: 'Nova Labs',
      school: 'Université de Paris',
      about:
          'Développeuse mobile passionnée par les interfaces soignées et les '
          'design systems. J’aime transformer des maquettes en produits fluides.',
      followers: 3480,
      profileViews: 142,
      searchAppearances: 38,
      connectionsCount: 512,
      experiences: [
        Experience(
          role: 'Développeuse Flutter senior',
          company: 'Nova Labs',
          period: 'janv. 2023 - aujourd’hui · 2 ans',
          location: 'Paris · Hybride',
          description:
              'Design system partagé, refonte du parcours d’onboarding, '
              'mentorat de deux alternant·es.',
        ),
        Experience(
          role: 'Développeuse mobile',
          company: 'Onde Bleue',
          period: 'sept. 2020 - déc. 2022 · 2 ans 4 mois',
          location: 'Nantes',
        ),
      ],
      educations: [
        Education(
          school: 'Université de Paris',
          degree: 'Master Informatique · Génie logiciel',
          period: '2018 - 2020',
        ),
      ],
      skills: ['Flutter', 'Dart', 'Design systems', 'Accessibilité', 'CI/CD'],
    ),
    const User(
      id: 'karim',
      name: 'Karim Benali',
      headline: 'Product Designer · Systèmes & recherche utilisateur',
      location: 'Lyon, France',
      degree: '1er',
      mutuals: 9,
      company: 'Studio Kanata',
      about: 'Designer produit, ex-agence. Je conçois des interfaces qui se '
          'comprennent sans mode d’emploi.',
      followers: 2110,
      profileViews: 87,
      searchAppearances: 21,
      connectionsCount: 430,
      experiences: [
        Experience(
          role: 'Product Designer',
          company: 'Studio Kanata',
          period: 'mars 2021 - aujourd’hui',
          location: 'Lyon · Télétravail',
        ),
      ],
      educations: [
        Education(
          school: 'École de design Nantes Atlantique',
          degree: 'Diplôme Design Interactif',
          period: '2014 - 2019',
        ),
      ],
      skills: ['UI Design', 'Prototypage', 'Design system', 'Figma'],
    ),
    const User(
      id: 'nadia',
      name: 'Nadia Cherif',
      headline: 'Talent Acquisition · Tech & Produit chez Horizon Tech',
      location: 'Alger, Algérie',
      degree: '2e',
      mutuals: 5,
      company: 'Horizon Tech',
      followers: 5400,
      connectionsCount: 890,
      about: 'Je connecte des équipes produit avec des personnes qui ont envie '
          'd’apprendre. Parlons-en.',
      skills: ['Recrutement', 'Sourcing', 'Marque employeur'],
    ),
    const User(
      id: 'lucas',
      name: 'Lucas Girard',
      headline: 'Engineering Manager · Forge Mobile',
      location: 'Bordeaux, France',
      degree: '2e',
      mutuals: 3,
      company: 'Forge Mobile',
      followers: 980,
      connectionsCount: 610,
      skills: ['Leadership', 'Flutter', 'Architecture'],
    ),
    const User(
      id: 'awa',
      name: 'Awa Diallo',
      headline: 'Étudiante en génie informatique · en recherche d’alternance',
      location: 'Conakry, Guinée',
      degree: '2e',
      mutuals: 7,
      school: 'Institut Supérieur de Technologie',
      followers: 210,
      connectionsCount: 180,
      skills: ['Dart', 'Java', 'Git'],
    ),
    const User(
      id: 'thomas',
      name: 'Thomas Rousseau',
      headline: 'Développeur Full Stack · Node.js / React / Flutter',
      location: 'Nantes, France',
      degree: '2e',
      mutuals: 2,
      company: 'Base14',
      followers: 640,
      connectionsCount: 500,
      skills: ['React', 'Node.js', 'PostgreSQL'],
    ),
    const User(
      id: 'ines',
      name: 'Inès Haddad',
      headline: 'UX Researcher · Cloudline',
      location: 'Marseille, France',
      degree: '3e',
      mutuals: 1,
      company: 'Cloudline',
      followers: 430,
      connectionsCount: 320,
      skills: ['Recherche utilisateur', 'Tests d’utilisabilité'],
    ),
    const User(
      id: 'kwame',
      name: 'Kwame Mensah',
      headline: 'Consultant Cloud · AWS & DevOps',
      location: 'Accra, Ghana',
      degree: '2e',
      mutuals: 4,
      company: 'Onde Bleue',
      followers: 1200,
      connectionsCount: 720,
      skills: ['AWS', 'Terraform', 'Kubernetes'],
    ),
  ];

  // --- Publications ---------------------------------------------------------

  static List<Post> posts() => [
    Post(
      id: 'p-design-system',
      authorId: 'sophie',
      author: 'Sophie Martin',
      role: 'Développeuse Flutter · Nova Labs',
      time: '2 h',
      content:
          'Très heureuse de partager notre nouveau guide interne sur les '
          'animations Flutter. Les micro-interactions bien dosées rendent une '
          'expérience mémorable — voici les 5 règles qu’on s’est fixées.\n\n'
          '#Flutter #DesignSystem #MobileDev',
      likes: 0,
      comments: 3,
      reposts: 6,
      media: PostMedia.image,
      imageSeed: 'guide-anim',
      reactions: {
        LiReaction.like: 128,
        LiReaction.insightful: 41,
        LiReaction.celebrate: 12,
      },
      commentList: [
        Comment(
          id: 'c1',
          authorId: 'karim',
          text: 'Excellente synthèse. La règle sur la durée sous 300 ms est '
              'vraiment celle qu’on oublie le plus.',
          time: '1 h',
          likes: 4,
          replies: [
            Comment(
              id: 'c1r1',
              authorId: 'sophie',
              text: 'Merci Karim ! Oui, on a mesuré, au-delà ça “traîne”.',
              time: '58 min',
              likes: 1,
              isAuthor: true,
            ),
          ],
        ),
        Comment(
          id: 'c2',
          authorId: 'lucas',
          text: 'On partage ça à l’équipe, merci 🙏',
          time: '32 min',
          likes: 2,
        ),
      ],
    ),
    Post(
      id: 'p-team',
      authorId: 'karim',
      author: 'Karim Benali',
      role: 'Product Designer · Studio Kanata',
      time: '4 h',
      content:
          'Une bonne équipe ne travaille pas seulement ensemble : elle prend '
          'aussi le temps de célébrer les progrès de chacun. Petit point '
          'rétro de la semaine.',
      likes: 0,
      comments: 1,
      reposts: 1,
      reactions: {LiReaction.like: 86, LiReaction.love: 9},
      commentList: [
        Comment(
          id: 'c3',
          authorId: 'ines',
          text: 'Tellement vrai.',
          time: '2 h',
          likes: 1,
        ),
      ],
    ),
    Post(
      id: 'p-hiring',
      authorId: 'nadia',
      author: 'Nadia Cherif',
      role: 'Talent Acquisition · Horizon Tech',
      time: '6 h',
      content:
          'Nous recherchons un·e développeur·se Flutter pour rejoindre une '
          'équipe produit bienveillante et ambitieuse. Poste en hybride, '
          'contrat CDI. Les cooptations sont ouvertes !',
      likes: 0,
      comments: 0,
      reposts: 11,
      isConnection: false,
      media: PostMedia.article,
      articleTitle: 'Développeur·se Flutter (H/F) — Horizon Tech',
      articleDomain: 'horizon-tech.jobs',
      reactions: {LiReaction.like: 241, LiReaction.celebrate: 34},
    ),
    Post(
      id: 'p-poll',
      authorId: 'lucas',
      author: 'Lucas Girard',
      role: 'Engineering Manager · Forge Mobile',
      time: '1 j',
      content: 'Pour la gestion d’état sur un nouveau projet Flutter, vous '
          'partez plutôt sur quoi en 2026 ?',
      likes: 0,
      comments: 2,
      isConnection: false,
      media: PostMedia.poll,
      pollOptions: [
        PollOption('Riverpod', 512),
        PollOption('Bloc', 384),
        PollOption('ValueNotifier / Provider', 173),
        PollOption('Autre chose', 64),
      ],
      reactions: {LiReaction.like: 47, LiReaction.insightful: 18},
    ),
    Post(
      id: 'p-doc',
      authorId: 'kwame',
      author: 'Kwame Mensah',
      role: 'Consultant Cloud · AWS & DevOps',
      time: '1 j',
      content:
          'J’ai compilé mes notes sur la mise en place d’un pipeline CI/CD '
          'pour app mobile. 12 pages, à réutiliser librement.',
      likes: 0,
      comments: 0,
      reposts: 3,
      isConnection: false,
      media: PostMedia.document,
      documentTitle: 'CI-CD-mobile-guide.pdf',
      documentPages: 12,
      reactions: {LiReaction.like: 63, LiReaction.insightful: 29},
    ),
  ];

  // --- Réseau --------------------------------------------------------------

  static List<String> invitationIds() => ['awa', 'thomas', 'ines'];
  static List<String> suggestionIds() =>
      ['lucas', 'kwame', 'nadia', 'thomas', 'ines', 'karim'];

  // --- Notifications ------------------------------------------------------

  static List<AppNotification> notifications() => [
    AppNotification(
      text: 'Sophie Martin a aimé votre publication.',
      time: '12 min',
      type: NotifType.reaction,
      actorId: 'sophie',
      actorName: 'Sophie Martin',
    ),
    AppNotification(
      text: 'Karim Benali a commenté votre publication : '
          '« Excellente synthèse… »',
      time: '1 h',
      type: NotifType.comment,
      actorId: 'karim',
      actorName: 'Karim Benali',
      cta: 'Répondre',
    ),
    AppNotification(
      text: 'Nadia Cherif vous a envoyé une invitation à vous connecter.',
      time: '3 h',
      type: NotifType.connection,
      actorId: 'nadia',
      actorName: 'Nadia Cherif',
      cta: 'Accepter',
    ),
    AppNotification(
      text: '5 nouvelles offres « Développeur Flutter » correspondent à '
          'votre profil.',
      time: '5 h',
      type: NotifType.job,
      actorId: 'nadia',
      cta: 'Voir les offres',
    ),
    AppNotification(
      text: 'Lucas Girard vous a mentionné·e dans un commentaire.',
      time: 'Hier',
      type: NotifType.mention,
      actorId: 'lucas',
      actorName: 'Lucas Girard',
      read: true,
    ),
    AppNotification(
      text: "C'est l'anniversaire de Thomas Rousseau aujourd'hui.",
      time: 'Hier',
      type: NotifType.birthday,
      actorId: 'thomas',
      actorName: 'Thomas Rousseau',
      cta: 'Souhaiter',
      read: true,
    ),
    AppNotification(
      text: 'Votre publication a été vue 340 fois cette semaine.',
      time: 'Il y a 2 j',
      type: NotifType.post,
      read: true,
    ),
  ];

  // --- Messagerie -------------------------------------------------------

  static List<Conversation> conversations() => [
    Conversation(
      id: 'conv-sophie',
      authorId: 'sophie',
      name: 'Sophie Martin',
      headline: 'Développeuse Flutter · Nova Labs',
      time: '10:24',
      online: true,
      unread: 2,
      messages: [
        ChatMessage(
          text: 'Bonjour ! As-tu vu le guide Flutter qu’on a publié ?',
          mine: false,
          time: '10:20',
          day: 'Aujourd’hui',
        ),
        ChatMessage(
          text: 'Oui, il est vraiment très clair. Bravo à l’équipe !',
          mine: true,
          time: '10:22',
          day: 'Aujourd’hui',
          status: 'Vu',
        ),
        ChatMessage(
          text: 'Merci 🙏 On prépare une V2 avec des exemples de code.',
          mine: false,
          time: '10:24',
          day: 'Aujourd’hui',
        ),
      ],
    ),
    Conversation(
      id: 'conv-karim',
      authorId: 'karim',
      name: 'Karim Benali',
      headline: 'Product Designer · Studio Kanata',
      time: 'Hier',
      messages: [
        ChatMessage(
          text: 'Merci pour ton retour sur la maquette, c’était utile.',
          mine: false,
          time: '18:03',
          day: 'Hier',
        ),
      ],
    ),
    Conversation(
      id: 'conv-nadia',
      authorId: 'nadia',
      name: 'Nadia Cherif',
      headline: 'Talent Acquisition · Horizon Tech',
      time: 'Lun.',
      unread: 1,
      messages: [
        ChatMessage(
          text: 'Bonjour, notre équipe souhaiterait échanger avec vous au '
              'sujet d’un poste Flutter. Auriez-vous 20 minutes cette semaine ?',
          mine: false,
          time: '09:15',
          day: 'Lundi',
        ),
      ],
    ),
    Conversation(
      id: 'conv-lucas',
      authorId: 'lucas',
      name: 'Lucas Girard',
      headline: 'Engineering Manager · Forge Mobile',
      time: 'Lun.',
      messages: [
        ChatMessage(
          text: 'On se cale un point la semaine prochaine ?',
          mine: true,
          time: '14:40',
          day: 'Lundi',
          status: 'Vu',
        ),
        ChatMessage(
          text: 'Parfait pour moi, mardi 11 h ?',
          mine: false,
          time: '15:02',
          day: 'Lundi',
        ),
      ],
    ),
  ];

  // --- Emplois --------------------------------------------------------

  static List<Job> jobs() => [
    Job(
      id: 'j1',
      title: 'Développeur·se Flutter',
      company: 'Nova Labs',
      location: 'Paris · Hybride',
      type: 'CDI',
      postedAgo: 'il y a 2 j',
      applicants: 47,
      promoted: true,
      activelyHiring: true,
      description:
          'Vous rejoignez une équipe produit de 6 personnes pour construire '
          'notre application grand public (500k utilisateurs). Stack : Flutter, '
          'Dart, GraphQL. Vous participez au design system et aux revues de '
          'code.',
      skills: ['Flutter', 'Dart', 'Tests', 'CI/CD', 'Git'],
    ),
    Job(
      id: 'j2',
      title: 'Ingénieur·e mobile senior',
      company: 'Horizon Tech',
      location: 'Lyon · Télétravail',
      type: 'CDI',
      postedAgo: 'il y a 1 sem.',
      applicants: 112,
      activelyHiring: true,
      description:
          'Poste senior avec responsabilité d’architecture sur nos apps iOS et '
          'Android en Flutter. Encadrement de 2 développeur·ses.',
      skills: ['Flutter', 'Architecture', 'Leadership', 'iOS', 'Android'],
    ),
    Job(
      id: 'j3',
      title: 'Développeur·se Full Stack (Node / React)',
      company: 'Base14',
      location: 'Nantes · Sur site',
      type: 'CDI',
      postedAgo: 'il y a 3 j',
      applicants: 30,
      easyApply: false,
      description:
          'Développement de nos outils internes et de l’espace client. '
          'Node.js, React, PostgreSQL.',
      skills: ['Node.js', 'React', 'PostgreSQL', 'TypeScript'],
    ),
    Job(
      id: 'j4',
      title: 'Product Designer',
      company: 'Studio Kanata',
      location: 'Remote (Europe)',
      type: 'CDI',
      postedAgo: 'il y a 5 j',
      applicants: 88,
      description:
          'Conception d’interfaces mobiles et web pour nos clients, du wireframe '
          'au design system.',
      skills: ['Figma', 'Design system', 'Prototypage'],
    ),
    Job(
      id: 'j5',
      title: 'Alternance — Développeur·se mobile',
      company: 'Forge Mobile',
      location: 'Bordeaux · Hybride',
      type: 'Alternance',
      postedAgo: "aujourd'hui",
      applicants: 9,
      activelyHiring: true,
      description:
          'Vous serez formé·e aux bonnes pratiques Flutter sur des projets '
          'clients réels, accompagné·e par un·e mentor.',
      skills: ['Dart', 'Flutter', 'Git', 'Motivation'],
    ),
    Job(
      id: 'j6',
      title: 'DevOps / Cloud Engineer',
      company: 'Cloudline',
      location: 'Marseille · Télétravail',
      type: 'CDI',
      postedAgo: 'il y a 6 j',
      applicants: 54,
      easyApply: false,
      description: 'Industrialisation de nos déploiements, IaC, observabilité.',
      skills: ['AWS', 'Terraform', 'Kubernetes', 'CI/CD'],
    ),
  ];
}
