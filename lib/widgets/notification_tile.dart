import 'package:flutter/material.dart';

import '../models/app_notification.dart';
import '../theme/app_tokens.dart';
import 'gen_avatar.dart';
import 'li_widgets.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
    this.onCta,
  });
  final AppNotification notification;
  final VoidCallback onTap;
  final VoidCallback? onCta;

  IconData get _badgeIcon => switch (notification.type) {
    NotifType.reaction => Icons.thumb_up,
    NotifType.comment => Icons.mode_comment,
    NotifType.connection => Icons.people,
    NotifType.job => Icons.work,
    NotifType.mention => Icons.alternate_email,
    NotifType.birthday => Icons.cake,
    NotifType.post => Icons.article,
  };

  @override
  Widget build(BuildContext context) {
    final n = notification;
    return InkWell(
      onTap: onTap,
      child: Container(
        color: n.read ? LiColors.surface : LiColors.unread,
        padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!n.read)
              Container(
                margin: const EdgeInsets.only(top: 18, right: 6),
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: LiColors.brand,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(width: 12),
            Stack(
              clipBehavior: Clip.none,
              children: [
                GenAvatar(
                  seed: n.seed,
                  name: n.actorName.isEmpty ? 'LinkedIn' : n.actorName,
                  size: 48,
                  shape: n.type == NotifType.job
                      ? AvatarShape.roundedSquare
                      : AvatarShape.circle,
                ),
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: LiColors.brand,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Icon(_badgeIcon, size: 11, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RichText(n.text, actor: n.actorName),
                  if (n.cta != null) ...[
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: onCta ?? onTap,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 34),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: Text(n.cta!),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 6),
            Column(
              children: [
                Text(
                  n.time,
                  style: TextStyle(fontSize: 12, color: LiColors.textTertiary),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => showLiOverflowSheet(
                    context,
                    items: const [
                      (icon: Icons.visibility_off_outlined, label: 'Masquer'),
                      (
                        icon: Icons.settings_outlined,
                        label: 'Désactiver ce type de notification'
                      ),
                    ],
                  ),
                  icon: Icon(Icons.more_horiz, color: LiColors.textTertiary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Met le nom de l'acteur en gras dans le texte de la notification.
class _RichText extends StatelessWidget {
  const _RichText(this.text, {required this.actor});
  final String text;
  final String actor;

  @override
  Widget build(BuildContext context) {
    if (actor.isEmpty || !text.contains(actor)) {
      return Text(text, style: const TextStyle(fontSize: 14));
    }
    final parts = text.split(actor);
    return Text.rich(
      TextSpan(
        style: const TextStyle(fontSize: 14, color: LiColors.textPrimary),
        children: [
          TextSpan(text: parts.first),
          TextSpan(
            text: actor,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          if (parts.length > 1) TextSpan(text: parts.sublist(1).join(actor)),
        ],
      ),
    );
  }
}
