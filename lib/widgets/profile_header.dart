import 'package:flutter/material.dart';
import 'avatar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.headline,
    required this.initials,
    required this.colorValue,
  });
  final String name, headline, initials;
  final int colorValue;
  @override
  Widget build(BuildContext context) => Stack(
    clipBehavior: Clip.none,
    children: [
      Container(height: 165, color: const Color(0xFF0A66C2)),
      Positioned(
        left: 20,
        top: 112,
        child: InitialAvatar(
          initials: initials,
          colorValue: colorValue,
          radius: 52,
        ),
      ),
      Positioned(
        right: 18,
        top: 105,
        child: IconButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Modification du profil simulée')),
          ),
          icon: const Icon(Icons.edit, color: Colors.white),
        ),
      ),
    ],
  );
}
