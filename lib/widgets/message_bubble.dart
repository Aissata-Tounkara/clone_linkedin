import 'package:flutter/material.dart';
import '../models/conversation.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});
  final ChatMessage message;
  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.88, end: 1),
    duration: const Duration(milliseconds: 180),
    curve: Curves.easeOut,
    builder: (context, value, child) => Transform.scale(
      scale: value,
      alignment: message.mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Opacity(opacity: value, child: child),
    ),
    child: Align(
      alignment: message.mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 290),
        decoration: BoxDecoration(
          color: message.mine
              ? const Color(0xFF0A66C2)
              : const Color(0xFFE9E9E9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: message.mine ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              message.time,
              style: TextStyle(
                color: message.mine ? Colors.white70 : Colors.black54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
