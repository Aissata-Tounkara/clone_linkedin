# Challenge UI - Équipe 03 - linkedln

Équipe 3 - Linkendin
Aïssata Tounkara 🇲🇱🇩🇿
Alpha Ousmane Bah 🇬🇳
TAWEMA Salomon 🇧🇯

## Application reproduite

**LinkedIn** (application mobile).

Reproduction fidèle du **front** de LinkedIn mobile : style, écrans et
micro-interactions. **Aucun backend, aucune base de données** — toutes les
données sont simulées et vivent en mémoire (elles sont réinitialisées à chaque
lancement).

## Technologies

- Flutter (Material 3)
- Dart
- `go_router` pour la navigation

Aucune dépendance réseau : les avatars, bannières et logos d'entreprise sont
**générés** (dégradés déterministes calculés à partir d'un « seed »), donc
l'application fonctionne 100 % hors ligne.

## Fonctionnalités UI

- **Authentification** : écrans Bienvenue / Connexion / Inscription
  (démonstration — n'importe quelle saisie connecte).
- **Fil d'actualité** : zone « Créer un post », cartes de publication,
  troncature « …voir plus », hashtags, scroll infini, pull-to-refresh,
  séparateur « Vous êtes à jour ».
- **Réactions** : appui long sur « J'aime » → barre des 6 réactions LinkedIn
  (J'aime, Bravo, Soutien, J'adore, Instructif, Amusant) avec animation et
  retour haptique ; preuve sociale (pile d'emojis + décomptes).
- **Commentaires** : feuille modale, réponses imbriquées (1 niveau), badge
  « Auteur », like d'un commentaire, composeur épinglé.
- **Médias de post** : image (dégradé), carte article, document, **sondage
  interactif**.
- **Mon réseau** : onglets Développer / Reprendre contact, invitations
  (Accepter / Ignorer), suggestions « Des personnes que vous connaissez
  peut-être », section « Gérer mon réseau ».
- **Notifications** : filtres (Tout / Mes publications / Mentions / Emplois),
  lignes typées avec pastille de type, boutons d'action, « Tout marquer comme
  lu », badge de compteur sur la barre de navigation.
- **Emplois** : recherche + filtres, offres recommandées, **page détail**
  (À propos du poste, compétences, entreprise), enregistrer / postuler
  (candidature simplifiée simulée).
- **Messagerie** : liste filtrable, page de conversation avec regroupement par
  jour, statut « Envoyé / Vu », **indicateur de saisie** animé et **réponse
  automatique** scriptée, nouvel écran « Nouveau message ».
- **Profil** (le sien et celui des autres) : bannière + avatar, carte
  Analyses, sections Activité / À propos / Expérience / Formation / Compétences
  / Centres d'intérêt, **édition du profil en mémoire** (se propage partout).
- **Recherche** : recherches récentes, suggestions, résultats à onglets
  (Tout / Personnes / Publications / Emplois / Entreprises).
- **Chrome global** : barre de navigation à 5 onglets avec badges, panneau
  latéral « Vous » (mini-profil, Préférences, Se déconnecter), transitions de
  page glissées.

## Widgets principaux

| Widget | Rôle |
|---|---|
| `GenAvatar` / `GenBanner` (`lib/widgets/gen_avatar.dart`) | Avatars et bannières générés (dégradé déterministe), hors ligne |
| `PostCard` (`lib/widgets/post_card.dart`) | Carte de publication complète du fil |
| `ReactionBar` / `ReactionStack` (`lib/widgets/reaction_bar.dart`) | Barre des réactions et pile d'emojis |
| `CommentsView` (`lib/widgets/comment_sheet.dart`) | Liste de commentaires + réponses + composeur |
| `ProfileHeader` (`lib/widgets/profile_header.dart`) | En-tête de profil (bannière, avatar, actions) |
| `JobCard` (`lib/widgets/job_card.dart`) | Carte d'offre d'emploi |
| `ConversationTile` (`lib/widgets/conversation_tile.dart`) | Ligne de conversation |
| `NotificationTile` (`lib/widgets/notification_tile.dart`) | Ligne de notification typée |
| `MePanel` (`lib/widgets/me_panel.dart`) | Panneau latéral « Vous » |
| `LinkedInBottomNavigationBar` | Barre de navigation avec badges |
| `li_widgets.dart` | Primitives partagées : `LiSectionCard`, `LiChipsRow`, `LiIconAction`, `LiBadge`, `LiHairline`, `LiSortHeader`, `showLiOverflowSheet` |

Architecture des données : un `Repository` unique (`lib/data/repository.dart`,
un `ChangeNotifier`) sert de source de vérité en mémoire ; les écrans
l'écoutent via `AnimatedBuilder`. Les données initiales sont dans
`lib/data/seed_data.dart`, les contenus additionnels du scroll infini dans
`lib/data/gen.dart`.

## Difficultés rencontrées

- Rendre l'app **visuellement réaliste sans aucune image ni accès réseau**
  (photos de profil, logos d'entreprise, bannières).
- Reproduire des interactions signature de LinkedIn : **barre de réactions à
  l'appui long**, troncature « …voir plus », **sondage** interactif,
  **indicateur de saisie**.
- Faire en sorte qu'une action (créer un post, accepter une invitation,
  envoyer un message, éditer le profil) se **répercute sur tous les écrans**
  sans backend.
- Fusion du travail de trois personnes (plusieurs dossiers d'écrans en
  parallèle).

## Solutions

- **Génération procédurale** : un hash FNV de la chaîne « seed » produit un
  dégradé HSL stable + initiales → avatars/bannières cohérents et hors ligne
  (`GenAvatar`, `GenBanner`).
- **Barre de réactions** affichée via `showDialog` positionné à l'ancre du
  bouton, animée avec `TweenAnimationBuilder` + `AnimatedScale`.
- **État partagé** : un seul `Repository` (`ChangeNotifier`) ; chaque écran
  se reconstruit sur `notifyListeners()`. La réponse automatique en
  messagerie utilise un `Timer`.
- **Système de design** centralisé (`lib/theme/app_tokens.dart` +
  `app_theme.dart`) : palette LinkedIn exacte, typo, formes, transitions.

## Screenshots

Captures dans le dossier `screenshots/` (fil d'actualité, publication +
réactions, mon réseau, notifications, profil, emplois, conversation).

## Vidéo

Lien Google Drive : _à compléter_

## APK

Lien Google Drive : _à compléter_

```bash
flutter build apk --release   # génère build/app/outputs/flutter-apk/app-release.apk
```

## Lancer le projet

```bash
flutter pub get
flutter run

# vérifications
flutter analyze
flutter test
```
