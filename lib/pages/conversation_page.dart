import 'package:flutter/material.dart';
import '../models/conversation.dart';
import '../screens/conversation_screen.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key, required this.conversation});
  final Conversation conversation;
  @override
  Widget build(BuildContext context) =>
      ConversationScreen(conversation: conversation);
}
