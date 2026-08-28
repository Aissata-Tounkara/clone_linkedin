import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';
import 'gen_avatar.dart';

/// En-tête de profil LinkedIn : bannière + avatar chevauchant + actions.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.seed,
    required this.name,
    required this.headline,
    this.location = '',
    this.degree = '',
    this.connections = 0,
    this.mutuals = 0,
    this.isMe = false,
    this.company = '',
    this.school = '',
    this.onEdit,
    this.onPrimary,
    this.onMessage,
    this.onMore,
  });

  final String seed, name, headline, location, degree, company, school;
  final int connections, mutuals;
  final bool isMe;
  final VoidCallback? onEdit, onPrimary, onMessage, onMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LiColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              GenBanner(seed: 'banner:$seed', height: 100),
              if (isMe)
                const Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.camera_alt, size: 16),
                  ),
                ),
              Positioned(
                left: 16,
                bottom: -36,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: GenAvatar(seed: seed, name: name, size: 88),
                ),
              ),
            ],
          ),
          const SizedBox(height: 44),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    if (degree.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '· $degree',
                          style: TextStyle(color: LiColors.textTertiary),
                        ),
                      ),
                    if (isMe && onEdit != null)
                      InkWell(
                        onTap: onEdit,
                        child: const Icon(Icons.edit_outlined),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(headline, style: const TextStyle(fontSize: 14)),
                if (company.isNotEmpty || school.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  _org(Icons.business_center, company),
                  _org(Icons.school, school),
                ],
                const SizedBox(height: 4),
                Text(
                  [
                    if (location.isNotEmpty) location,
                    'Coordonnées',
                  ].join(' · '),
                  style: TextStyle(fontSize: 12, color: LiColors.textSecondary),
                ),
                const SizedBox(height: 6),
                Text(
                  isMe
                      ? '$connections relations'
                      : mutuals > 0
                      ? '$mutuals relations en commun'
                      : '$connections relations',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: LiColors.brand,
                  ),
                ),
                const SizedBox(height: 12),
                _actions(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _org(IconData icon, String text) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: LiColors.textSecondary),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget _actions(BuildContext context) {
    if (isMe) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onPrimary,
              child: const Text('Ajouter une section'),
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: onEdit,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: LiColors.border),
              foregroundColor: LiColors.textSecondary,
            ),
            child: const Text('Améliorer le profil'),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: onPrimary,
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Se connecter'),
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton(onPressed: onMessage, child: const Text('Message')),
        const SizedBox(width: 4),
        OutlinedButton(
          onPressed: onMore,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: LiColors.border),
            foregroundColor: LiColors.textSecondary,
            padding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          child: const Icon(Icons.more_horiz, size: 18),
        ),
      ],
    );
  }
}
