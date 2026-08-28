import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repository.dart';
import '../models/app_notification.dart';
import '../widgets/avatar.dart';
import '../widgets/empty_state.dart';
import '../widgets/li_widgets.dart';
import '../widgets/notification_tile.dart';
import '../theme/app_tokens.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _repo = Repository.instance;
  String _filter = 'Tout';

  static const _filters = ['Tout', 'Mes publications', 'Mentions', 'Emplois'];

  bool _match(AppNotification n) => switch (_filter) {
    'Emplois' => n.type == NotifType.job,
    'Mes publications' =>
      n.type == NotifType.reaction || n.type == NotifType.comment ||
          n.type == NotifType.post,
    'Mentions' => n.type == NotifType.mention,
    _ => true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => context.push('/profile'),
              child: const CurrentUserAvatar(radius: 16),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: LiColors.searchField,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search,
                        size: 20, color: LiColors.textSecondary),
                    const SizedBox(width: 8),
                    Text('Rechercher',
                        style: TextStyle(color: LiColors.textSecondary)),
                  ],
                ),
              ),
            ),
            IconButton(
              tooltip: 'Tout marquer comme lu',
              onPressed: _repo.markAllNotificationsRead,
              icon: const Icon(Icons.done_all),
            ),
          ],
        ),
      ),
      body: AnimatedBuilder(
        animation: _repo,
        builder: (context, _) {
          final items = _repo.notifications.where(_match).toList();
          return Column(
            children: [
              LiChipsRow(
                options: _filters,
                selected: _filter,
                onSelected: (v) => setState(() => _filter = v),
              ),
              const Divider(height: 1),
              Expanded(
                child: items.isEmpty
                    ? const EmptyState(
                        icon: Icons.notifications_off_outlined,
                        title: 'Aucune notification',
                        message: 'Vos interactions apparaîtront ici.',
                      )
                    : ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (_, i) => NotificationTile(
                          notification: items[i],
                          onTap: () => _repo.markNotificationRead(items[i]),
                          onCta: () {
                            _repo.markNotificationRead(items[i]);
                            _handleCta(items[i]);
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleCta(AppNotification n) {
    switch (n.type) {
      case NotifType.job:
        context.push('/jobs');
      case NotifType.connection:
        context.push('/network');
      case NotifType.comment:
      case NotifType.mention:
      case NotifType.reaction:
      case NotifType.post:
      case NotifType.birthday:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(n.cta ?? 'Ouvert'),
            duration: const Duration(milliseconds: 900),
          ),
        );
    }
  }
}
