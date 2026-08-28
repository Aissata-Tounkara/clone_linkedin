import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repository.dart';
import '../widgets/avatar.dart';
import '../widgets/conversation_tile.dart';
import '../widgets/empty_state.dart';
import '../widgets/li_widgets.dart';
import '../theme/app_tokens.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _repo = Repository.instance;
  String _filter = 'Zone de réception';
  String _query = '';

  static const _filters = [
    'Zone de réception',
    'Non lus',
    'Mes relations',
    'InMail',
  ];

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
                    Expanded(
                      child: TextField(
                        onChanged: (v) => setState(() => _query = v),
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: 'Rechercher dans la messagerie',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/messaging/new'),
        backgroundColor: LiColors.brand,
        foregroundColor: Colors.white,
        child: const Icon(Icons.edit_square),
      ),
      body: AnimatedBuilder(
        animation: _repo,
        builder: (context, _) {
          var list = _repo.conversations.where(
            (c) => c.name.toLowerCase().contains(_query.toLowerCase()),
          );
          if (_filter == 'Non lus') {
            list = list.where((c) => c.unread > 0);
          }
          final conversations = list.toList();
          return Column(
            children: [
              LiChipsRow(
                options: _filters,
                selected: _filter,
                onSelected: (v) => setState(() => _filter = v),
              ),
              const Divider(height: 1),
              Expanded(
                child: conversations.isEmpty
                    ? const EmptyState(
                        icon: Icons.forum_outlined,
                        title: 'Aucune conversation',
                        message: 'Vos messages apparaîtront ici.',
                      )
                    : ListView.separated(
                        itemCount: conversations.length,
                        separatorBuilder: (_, _) =>
                            const Divider(height: 1, indent: 84),
                        itemBuilder: (_, i) => ConversationTile(
                          conversation: conversations[i],
                          onTap: () => context.push(
                            '/conversation/${conversations[i].id}',
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
