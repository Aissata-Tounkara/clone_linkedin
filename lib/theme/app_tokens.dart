import 'package:flutter/material.dart';

/// Jetons de design alignés sur l'app LinkedIn mobile.
///
/// Couleurs, rayons et durées d'animation regroupés ici pour garder un rendu
/// cohérent sur tous les écrans.
class LiColors {
  LiColors._();

  /// Bleu de marque LinkedIn.
  static const brand = Color(0xFF0A66C2);
  static const brandHover = Color(0xFF004182);
  static const brandTint = Color(0xFFEAF3FC);

  /// Fond du fil d'actualité (gris chaud).
  static const canvas = Color(0xFFF4F2EE);
  static const surface = Colors.white;

  /// Texte : LinkedIn utilise du noir à opacité variable.
  static const textPrimary = Color(0xE6000000); // rgba(0,0,0,.90)
  static const textSecondary = Color(0x99000000); // rgba(0,0,0,.60)
  static const textTertiary = Color(0x8A000000); // rgba(0,0,0,.54)

  /// Vert « développer / candidature simplifiée ».
  static const green = Color(0xFF01754F);
  static const greenDark = Color(0xFF057642);

  /// Séparateurs.
  static const hairline = Color(0xFFE8E8E8);
  static const border = Color(0x26000000);

  /// Pastille de notification.
  static const badge = Color(0xFFCB112D);

  /// Premium.
  static const gold = Color(0xFFE7A33E);
  static const goldText = Color(0xFF915907);

  /// Fond « non lu » (notifications, messagerie).
  static const unread = Color(0xFFEAF3FC);

  /// Champ de recherche dans les barres d'app.
  static const searchField = Color(0xFFEEF3F8);

  /// Bulle de message reçue.
  static const bubbleIn = Color(0xFFF2F2F2);
}

class LiRadius {
  LiRadius._();
  static const card = 8.0;
  static const media = 2.0;
  static const chip = 999.0;
}

class LiDuration {
  LiDuration._();
  static const fast = Duration(milliseconds: 140);
  static const base = Duration(milliseconds: 220);
  static const slow = Duration(milliseconds: 320);
}

/// Réactions LinkedIn, dans l'ordre de la barre au survol.
enum LiReaction { like, celebrate, support, love, insightful, funny }

extension LiReactionData on LiReaction {
  String get label => switch (this) {
    LiReaction.like => "J'aime",
    LiReaction.celebrate => 'Bravo',
    LiReaction.support => 'Soutien',
    LiReaction.love => "J'adore",
    LiReaction.insightful => 'Instructif',
    LiReaction.funny => 'Amusant',
  };

  String get emoji => switch (this) {
    LiReaction.like => '👍',
    LiReaction.celebrate => '👏',
    LiReaction.support => '🤝',
    LiReaction.love => '❤️',
    LiReaction.insightful => '💡',
    LiReaction.funny => '😄',
  };

  Color get color => switch (this) {
    LiReaction.like => LiColors.brand,
    LiReaction.celebrate => LiColors.greenDark,
    LiReaction.support => const Color(0xFF715E8B),
    LiReaction.love => const Color(0xFFB24020),
    LiReaction.insightful => const Color(0xFFE7A33E),
    LiReaction.funny => const Color(0xFF44712E),
  };

  IconData get icon => switch (this) {
    LiReaction.like => Icons.thumb_up,
    LiReaction.celebrate => Icons.celebration,
    LiReaction.support => Icons.volunteer_activism,
    LiReaction.love => Icons.favorite,
    LiReaction.insightful => Icons.lightbulb,
    LiReaction.funny => Icons.sentiment_very_satisfied,
  };
}
