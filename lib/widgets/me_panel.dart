import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repository.dart';
import '../state/current_user.dart';
import '../theme/app_tokens.dart';
import 'avatar.dart';

/// Panneau « Vous » (drawer gauche de LinkedIn) : mini-carte de profil,
/// raccourcis et déconnexion.
class MePanel extends StatelessWidget {
  const MePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = Repository.instance;
    return Drawer(
      backgroundColor: LiColors.surface,
      child: SafeArea(
        child: AnimatedBuilder(
          animation: Listenable.merge([repo, CurrentUser.profile]),
          builder: (context, _) {
            final me = repo.me;
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          context.push('/profile');
                        },
                        child: Row(
                          children: [
                            const CurrentUserAvatar(radius: 26),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    me.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Voir le profil',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: LiColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _stat('${me.profileViews}', 'vues du profil'),
                          const SizedBox(width: 16),
                          _stat('${me.connectionsCount}', 'relations'),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                _tile(context, Icons.bookmark_border, 'Mes éléments'),
                _tile(context, Icons.groups_outlined, 'Groupes'),
                _tile(context, Icons.event_outlined, 'Événements'),
                _tile(context, Icons.newspaper, 'Newsletters'),
                const Divider(),
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F0E3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(width: 14, height: 14, color: LiColors.gold),
                          const SizedBox(width: 6),
                          const Text(
                            'Essayez Premium',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Débloquez les analyses et les cours (simulation).',
                        style: TextStyle(
                          fontSize: 12,
                          color: LiColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                _tile(context, Icons.settings_outlined, 'Préférences'),
                ListTile(
                  leading: const Icon(Icons.logout, color: LiColors.badge),
                  title: const Text(
                    'Se déconnecter',
                    style: TextStyle(color: LiColors.badge),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.go('/auth');
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _stat(String value, String label) => Row(
    children: [
      Text(value,
          style: const TextStyle(
              fontWeight: FontWeight.w700, color: LiColors.brand)),
      const SizedBox(width: 4),
      Text(label,
          style: TextStyle(fontSize: 12, color: LiColors.textSecondary)),
    ],
  );

  Widget _tile(BuildContext context, IconData icon, String label) => ListTile(
    leading: Icon(icon, color: LiColors.textSecondary),
    title: Text(label),
    onTap: () {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(label), duration: const Duration(milliseconds: 800)),
      );
    },
  );
}
