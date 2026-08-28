import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repository.dart';
import '../data/seed_data.dart';
import '../models/user.dart';
import '../theme/app_tokens.dart';
import '../widgets/gen_avatar.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final people = Seed.users.values
        .where((u) => u.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Nouveau message')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              autofocus: true,
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'À : nom d’une relation',
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Suggestions',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: LiColors.textSecondary,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (final User u in people)
                  ListTile(
                    leading: GenAvatar(seed: u.seed, name: u.name, size: 44),
                    title: Text(u.name,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(
                      u.headline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      final conv =
                          Repository.instance.openConversationWith(u);
                      context.pushReplacement('/conversation/${conv.id}');
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
