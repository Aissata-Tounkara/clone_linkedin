import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repository.dart';
import '../models/user.dart';
import '../theme/app_tokens.dart';
import '../widgets/gen_avatar.dart';
import '../widgets/li_widgets.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  int _tab = 0;
  final _repo = Repository.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: LiColors.searchField,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(Icons.search, size: 20, color: LiColors.textSecondary),
              const SizedBox(width: 8),
              Text('Rechercher',
                  style: TextStyle(color: LiColors.textSecondary)),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push('/messaging'),
            icon: const Icon(Icons.chat_bubble_outline),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: Row(
            children: [
              _SegTab(
                label: 'Développer',
                selected: _tab == 0,
                onTap: () => setState(() => _tab = 0),
              ),
              _SegTab(
                label: 'Reprendre contact',
                selected: _tab == 1,
                onTap: () => setState(() => _tab = 1),
              ),
            ],
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: _repo,
        builder: (context, _) {
          final invites = _repo.invitations;
          final suggestions = _repo.suggestions;
          return ListView(
            children: [
              const LiBlockGap(height: 1),
              Container(
                color: LiColors.surface,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Invitations${invites.isEmpty ? '' : ' (${invites.length})'}',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      trailing: const Text('Voir tout'),
                    ),
                    const Divider(height: 1),
                    if (invites.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Aucune invitation en attente.',
                          style: TextStyle(color: LiColors.textSecondary),
                        ),
                      )
                    else
                      for (final u in invites)
                        _InvitationTile(
                          user: u,
                          onAccept: () {
                            _repo.acceptInvitation(u);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Vous êtes maintenant en relation avec ${u.name}.',
                                ),
                              ),
                            );
                          },
                          onIgnore: () => _repo.ignoreInvitation(u),
                          onOpen: () => context.push('/u/${u.id}'),
                        ),
                  ],
                ),
              ),
              const LiBlockGap(),
              Container(
                color: LiColors.surface,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                child: const Text(
                  'Des personnes que vous connaissez peut-être',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
              Container(
                color: LiColors.surface,
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.62,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    for (final u in suggestions)
                      _SuggestionCard(
                        user: u,
                        onConnect: () {
                          _repo.connect(u);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Invitation envoyée à ${u.name}'),
                              duration: const Duration(milliseconds: 900),
                            ),
                          );
                        },
                        onDismiss: () => _repo.dismissSuggestion(u),
                        onOpen: () => context.push('/u/${u.id}'),
                      ),
                  ],
                ),
              ),
              const LiBlockGap(),
              Container(
                color: LiColors.surface,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 14, 16, 6),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Gérer mon réseau',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                    for (final item in const [
                      (Icons.people_outline, 'Relations'),
                      (Icons.contact_page_outlined, 'Contacts'),
                      (Icons.rss_feed, 'Suivis et abonnés'),
                      (Icons.groups_outlined, 'Groupes'),
                      (Icons.event_outlined, 'Événements'),
                      (Icons.article_outlined, 'Pages'),
                      (Icons.newspaper, 'Newsletters'),
                    ])
                      ListTile(
                        leading: Icon(item.$1, color: LiColors.textSecondary),
                        title: Text(item.$2),
                        trailing: Text(
                          item.$2 == 'Relations' ? '${_repo.relationsCount}' : '',
                          style: TextStyle(color: LiColors.textSecondary),
                        ),
                        onTap: () {},
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}

class _SegTab extends StatelessWidget {
  const _SegTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? LiColors.greenDark : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? LiColors.greenDark : LiColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _InvitationTile extends StatelessWidget {
  const _InvitationTile({
    required this.user,
    required this.onAccept,
    required this.onIgnore,
    required this.onOpen,
  });
  final User user;
  final VoidCallback onAccept, onIgnore, onOpen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onOpen,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GenAvatar(seed: user.seed, name: user.name, size: 56),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15)),
                  Text(
                    user.headline,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 13, color: LiColors.textSecondary),
                  ),
                  if (user.mutuals > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        '${user.mutuals} relations en commun',
                        style: TextStyle(
                            fontSize: 12, color: LiColors.textTertiary),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: onIgnore,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: LiColors.border),
                          foregroundColor: LiColors.textSecondary,
                        ),
                        child: const Text('Ignorer'),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: onAccept,
                        child: const Text('Accepter'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({
    required this.user,
    required this.onConnect,
    required this.onDismiss,
    required this.onOpen,
  });
  final User user;
  final VoidCallback onConnect, onDismiss, onOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: LiColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                GenBanner(seed: 'b:${user.seed}', height: 54),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 18,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child:
                          GenAvatar(seed: user.seed, name: user.name, size: 64),
                    ),
                  ),
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: InkWell(
                    onTap: onDismiss,
                    child: const Icon(Icons.close, size: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Text(
                    user.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Text(
                    user.headline,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12, color: LiColors.textSecondary),
                  ),
                  if (user.mutuals > 0)
                    Text(
                      '${user.mutuals} relations en commun',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11, color: LiColors.textTertiary),
                    ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: OutlinedButton.icon(
                onPressed: onConnect,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Se connecter'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(36),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
