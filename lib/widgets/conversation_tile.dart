import 'package:flutter/material.dart';
import '../models/conversation.dart';
import 'avatar.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    super.key,
    required this.conversation,
    required this.onTap,
  });
  final Conversation conversation;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    leading: InitialAvatar(
      initials: conversation.initials,
      colorValue: conversation.colorValue,
    ),
    title: Text(
      conversation.name,
      style: TextStyle(
        fontWeight: conversation.unread > 0 ? FontWeight.w700 : FontWeight.w500,
      ),
    ),
    subtitle: Text(
      conversation.preview,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(conversation.time, style: const TextStyle(fontSize: 12)),
        if (conversation.unread > 0) ...[
          const SizedBox(height: 4),
          CircleAvatar(
            radius: 10,
            backgroundColor: const Color(0xFF0A66C2),
            child: Text(
              '${conversation.unread}',
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
        ],
      ],
    ),
  );
}
