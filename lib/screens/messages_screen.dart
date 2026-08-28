import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/local_data.dart';
import '../widgets/conversation_tile.dart';
import '../widgets/empty_state.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Messagerie'),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Icon(Icons.edit_outlined),
        ),
      ],
    ),
    body: LocalData.conversations.isEmpty
        ? const EmptyState(
            icon: Icons.forum_outlined,
            title: 'Aucune conversation',
            message: 'Vos messages apparaîtront ici.',
          )
        : ListView.separated(
            itemCount: LocalData.conversations.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (_, index) => ConversationTile(
              conversation: LocalData.conversations[index],
              onTap: () => context.push('/conversation/$index'),
            ),
          ),
  );
}
