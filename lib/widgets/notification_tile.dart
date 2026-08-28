import 'package:flutter/material.dart';
import '../models/app_notification.dart';
import 'avatar.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });
  final AppNotification notification;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      color: notification.read ? Colors.white : const Color(0xFFE8F3FF),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        children: [
          InitialAvatar(
            initials: notification.initials,
            colorValue: notification.colorValue,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.text,
                  style: TextStyle(
                    fontWeight: notification.read
                        ? FontWeight.w400
                        : FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  notification.time,
                  style: const TextStyle(color: Color(0xFF666666)),
                ),
              ],
            ),
          ),
          if (!notification.read)
            const Icon(Icons.circle, size: 10, color: Color(0xFF0A66C2)),
        ],
      ),
    ),
  );
}
