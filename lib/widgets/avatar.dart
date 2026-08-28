import 'package:flutter/material.dart';
import '../state/current_user.dart';
import 'gen_avatar.dart';

/// Ancien avatar « initiales sur fond plat » conservé pour compatibilité : il
/// rend désormais un dégradé généré ([GenAvatar]) pour un look proche de
/// LinkedIn, sans changer l'API appelée par les écrans existants.
class InitialAvatar extends StatelessWidget {
  const InitialAvatar({
    super.key,
    required this.initials,
    required this.colorValue,
    this.radius = 22,
    this.shape = AvatarShape.circle,
  });
  final String initials;
  final int colorValue;
  final double radius;
  final AvatarShape shape;

  @override
  Widget build(BuildContext context) => GenAvatar(
    seed: '$initials-$colorValue',
    name: initials,
    size: radius * 2,
    shape: shape,
  );
}

class CurrentUserAvatar extends StatelessWidget {
  const CurrentUserAvatar({super.key, this.radius = 22});

  final double radius;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<CurrentUserProfile>(
        valueListenable: CurrentUser.profile,
        builder: (context, profile, _) {
          final name = profile.displayName.isEmpty
              ? 'Vous'
              : profile.displayName;
          return GenAvatar(seed: 'me:$name', name: name, size: radius * 2);
        },
      );
}
