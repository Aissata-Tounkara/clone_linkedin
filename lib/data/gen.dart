import '../models/post.dart';
import '../theme/app_tokens.dart';

/// Générateurs déterministes pour alimenter le scroll infini du feed sans
/// backend. Mêmes entrées → mêmes sorties.

const _firstNames = [
  'Awa', 'Ibrahim', 'Léa', 'Mamadou', 'Chloé', 'Youssef', 'Fatoumata',
  'Thomas', 'Aminata', 'Lucas', 'Nadia', 'Omar', 'Sarah', 'Kwame', 'Julie',
  'Cheikh', 'Emma', 'Bakary', 'Inès', 'Antoine',
];
const _lastNames = [
  'Diallo', 'Traoré', 'Bernard', 'Keïta', 'Moreau', 'Benali', 'Cissé',
  'Petit', 'Sow', 'Girard', 'Haddad', 'Fofana', 'Rousseau', 'Mensah',
  'Dubois', 'Ndiaye', 'Lefèvre', 'Camara', 'Barry', 'Faure',
];
const _headlines = [
  'Développeur·se Flutter',
  'Product Designer',
  'Ingénieur·e logiciel · Mobile',
  'Recruteur·se Tech',
  'Data Analyst',
  'Fondateur·rice · Studio produit',
  'Développeur·se Full Stack',
  'UX Researcher',
  'Engineering Manager',
  'Consultant·e Cloud',
];
const _companies = [
  'Nova Labs', 'Atelier Digital', 'Pixel & Co', 'Cloudline', 'Motion Apps',
  'Studio Kanata', 'Horizon Tech', 'Onde Bleue', 'Forge Mobile', 'Base14',
];
const _snippets = [
  'Petit rappel : une bonne architecture, c’est surtout du code qu’on peut supprimer sans peur. On a refactoré cette semaine et le résultat est net.',
  'Après 6 mois sur Flutter, mon retour : la vélocité produit est réelle, mais investissez tôt dans un design system partagé.',
  'On recrute ! Un poste de développeur·se mobile dans une équipe bienveillante, en hybride. Les cooptations sont les bienvenues 🙌',
  'Le meilleur conseil de carrière que j’ai reçu : documente ce que tu apprends, pas seulement ce que tu livres.',
  'Fière d’annoncer que notre application vient de passer les 100 000 utilisateurs. Merci à toute l’équipe pour ces mois intenses.',
  'Les animations ne sont pas de la décoration : bien dosées, elles réduisent la charge cognitive et guident l’utilisateur.',
  'J’ai passé la journée à lire du code plutôt qu’à en écrire. Journée très productive.',
  'Accessibilité : contrastez vos textes, agrandissez vos cibles tactiles, testez au lecteur d’écran. Ça profite à tout le monde.',
];

int _hash(String s) {
  var h = 0x811c9dc5;
  for (final c in s.codeUnits) {
    h ^= c;
    h = (h * 0x01000193) & 0xFFFFFFFF;
  }
  return h;
}

String _name(int n) =>
    '${_firstNames[n % _firstNames.length]} '
    '${_lastNames[(n ~/ 3) % _lastNames.length]}';

/// Génère [count] publications supplémentaires pour le fil, à partir d'un
/// décalage stable.
List<Post> moreFeedPosts(int offset, int count) {
  return List.generate(count, (i) {
    final n = offset + i;
    final h = _hash('feed-$n');
    final author = _name(n);
    final hasImage = h % 5 == 0;
    final hasArticle = !hasImage && h % 7 == 0;
    return Post(
      id: 'gen-$n',
      authorId: 'gen-$n',
      author: author,
      role: _headlines[h % _headlines.length],
      time: '${1 + h % 22} h',
      content: _snippets[h % _snippets.length],
      likes: 0,
      comments: h % 14,
      reposts: h % 4,
      isConnection: h % 3 != 0,
      media: hasImage
          ? PostMedia.image
          : hasArticle
          ? PostMedia.article
          : PostMedia.none,
      imageSeed: hasImage ? 'img-$n' : null,
      articleTitle: hasArticle ? 'Ce que j’ai appris en scalant une équipe' : null,
      articleDomain: hasArticle ? 'blog.$author.dev'.toLowerCase() : null,
      reactions: {
        LiReaction.like: 3 + h % 180,
        LiReaction.celebrate: h % 25,
        LiReaction.insightful: h % 40,
      },
    );
  });
}

String genCompany(int n) => _companies[n % _companies.length];
