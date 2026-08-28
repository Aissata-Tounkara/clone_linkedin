import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Génération d'images 100 % hors ligne : à partir d'une chaîne « seed »
/// (un nom, un id), on dérive un dégradé déterministe. Aucun fichier, aucun
/// réseau — remplace les photos de profil, logos et bannières.

int _seedOf(String s) {
  var h = 0x811c9dc5;
  for (final c in s.codeUnits) {
    h ^= c;
    h = (h * 0x01000193) & 0xFFFFFFFF;
  }
  return h;
}

/// Deux à trois teintes cohérentes dérivées du seed.
List<Color> gradientFor(String seed) {
  final h = _seedOf(seed.isEmpty ? 'li' : seed);
  final hue = (h % 360).toDouble();
  final hue2 = (hue + 24 + (h >> 8) % 40) % 360;
  final sat = 0.55 + ((h >> 16) % 25) / 100;
  return [
    HSLColor.fromAHSL(1, hue, sat, 0.52).toColor(),
    HSLColor.fromAHSL(1, hue2, sat, 0.38).toColor(),
  ];
}

String initialsOf(String name) {
  final parts = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((p) => p.isNotEmpty)
      .toList();
  if (parts.isEmpty) return '?';
  if (parts.length == 1) return parts.first.characters.first.toUpperCase();
  return (parts.first.characters.first + parts.last.characters.first)
      .toUpperCase();
}

enum AvatarShape { circle, roundedSquare }

class GenAvatar extends StatelessWidget {
  const GenAvatar({
    super.key,
    required this.seed,
    this.name,
    this.size = 48,
    this.shape = AvatarShape.circle,
    this.ring = false,
  });

  /// Chaîne stable qui détermine les couleurs (souvent l'id ou le nom).
  final String seed;

  /// Nom affiché en initiales (si null, on prend [seed]).
  final String? name;
  final double size;
  final AvatarShape shape;
  final bool ring;

  @override
  Widget build(BuildContext context) {
    final colors = gradientFor(seed);
    final radius = shape == AvatarShape.circle ? size : size * 0.22;
    final child = Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radius),
        border: ring ? Border.all(color: Colors.white, width: 2) : null,
      ),
      child: Text(
        initialsOf(name ?? seed),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.4,
          letterSpacing: 0,
        ),
      ),
    );
    return child;
  }
}

/// Bannière de profil : dégradé + formes géométriques douces.
class GenBanner extends StatelessWidget {
  const GenBanner({super.key, required this.seed, this.height = 96});
  final String seed;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = gradientFor(seed);
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _BannerPainter(colors, _seedOf(seed))),
    );
  }
}

class _BannerPainter extends CustomPainter {
  _BannerPainter(this.colors, this.seed);
  final List<Color> colors;
  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(rect),
    );
    final overlay = Paint()..color = Colors.white.withValues(alpha: 0.10);
    final rng = math.Random(seed);
    for (var i = 0; i < 3; i++) {
      final c = Offset(
        rng.nextDouble() * size.width,
        rng.nextDouble() * size.height,
      );
      canvas.drawCircle(c, size.height * (0.4 + rng.nextDouble() * 0.6), overlay);
    }
  }

  @override
  bool shouldRepaint(_BannerPainter oldDelegate) =>
      oldDelegate.seed != seed || oldDelegate.colors != colors;
}
