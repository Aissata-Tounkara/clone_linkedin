import 'package:flutter/material.dart';
import '../models/conversation.dart';
import '../widgets/avatar.dart';
import '../widgets/message_bubble.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key, required this.conversation});
  final Conversation conversation;
  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.conversation.unread = 0;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void send() {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      widget.conversation.messages.add(
        ChatMessage(text: text, mine: true, time: 'Maintenant'),
      );
      controller.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Message envoyé'),
        duration: Duration(milliseconds: 700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Row(
        children: [
          InitialAvatar(
            initials: widget.conversation.initials,
            colorValue: widget.conversation.colorValue,
            radius: 17,
          ),
          const SizedBox(width: 9),
          Text(widget.conversation.name),
        ],
      ),
    ),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: widget.conversation.messages.length,
            itemBuilder: (_, index) =>
                MessageBubble(message: widget.conversation.messages[index]),
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pièce jointe simulée')),
                  ),
                  tooltip: 'Ajouter une pièce jointe',
                  icon: const Icon(Icons.attach_file),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (_) => send(),
                    decoration: InputDecoration(
                      hintText: 'Écrire un message',
                      filled: true,
                      fillColor: const Color(0xFFF1F1F1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: send,
                  tooltip: 'Envoyer le message',
                  color: const Color(0xFF0A66C2),
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
