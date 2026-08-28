import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repository.dart';
import '../data/seed_data.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../state/current_user.dart';
import '../theme/app_tokens.dart';
import '../widgets/gen_avatar.dart';
import '../widgets/li_widgets.dart';
import '../widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.userId});

  /// null → mon profil ; sinon profil public.
  final String? userId;

  @override
  Widget build(BuildContext context) {
    final repo = Repository.instance;
    return AnimatedBuilder(
      animation: Listenable.merge([repo, CurrentUser.profile]),
      builder: (context, _) {
        final isMe = userId == null;
        final User user = isMe ? repo.me : Seed.user(userId!);
        final seed = isMe ? repo.mySeed : user.seed;
        final posts = repo.postsBy(isMe ? 'me' : user.id);

        return Scaffold(
          appBar: AppBar(
            title: Text(isMe ? 'Profil' : user.name),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined),
              ),
              if (isMe)
                IconButton(
                  onPressed: () => context.push('/edit-profile'),
                  icon: const Icon(Icons.edit_outlined),
                ),
            ],
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              ProfileHeader(
                seed: seed,
                name: user.name,
                headline: user.headline,
                location: user.location,
                degree: user.degree,
                connections: user.connectionsCount,
                mutuals: user.mutuals,
                company: user.company,
                school: user.school,
                isMe: isMe,
                onEdit: () => context.push('/edit-profile'),
                onPrimary: () => _snack(
                  context,
                  isMe ? 'Sélectionnez une section à ajouter' : 'Invitation envoyée',
                ),
                onMessage: () {
                  final conv = repo.openConversationWith(user);
                  context.push('/conversation/${conv.id}');
                },
                onMore: () => _snack(context, 'Plus d’actions (simulation)'),
              ),
              const LiBlockGap(),
              if (isMe) ...[
                _AnalyticsCard(user: user),
                const LiBlockGap(),
              ],
              _ActivitySection(isMe: isMe, name: user.name, posts: posts),
              const LiBlockGap(),
              if (user.about.isNotEmpty) ...[
                LiSectionCard(
                  title: 'À propos',
                  action: isMe ? Icons.edit_outlined : null,
                  onAction: () => context.push('/edit-profile'),
                  child: Text(user.about),
                ),
                const LiBlockGap(),
              ],
              if (user.experiences.isNotEmpty) ...[
                LiSectionCard(
                  title: 'Expérience',
                  action: isMe ? Icons.add : null,
                  onAction: () => _snack(context, 'Ajouter une expérience'),
                  child: Column(
                    children: [
                      for (final e in user.experiences)
                        _ExperienceTile(
                          role: e.role,
                          company: e.company,
                          period: e.period,
                          location: e.location,
                          description: e.description,
                        ),
                    ],
                  ),
                ),
                const LiBlockGap(),
              ],
              if (user.educations.isNotEmpty) ...[
                LiSectionCard(
                  title: 'Formation',
                  action: isMe ? Icons.add : null,
                  onAction: () => _snack(context, 'Ajouter une formation'),
                  child: Column(
                    children: [
                      for (final ed in user.educations)
                        _ExperienceTile(
                          role: ed.school,
                          company: ed.degree,
                          period: ed.period,
                          location: '',
                          description: '',
                          icon: Icons.school,
                        ),
                    ],
                  ),
                ),
                const LiBlockGap(),
              ],
              if (user.skills.isNotEmpty) ...[
                LiSectionCard(
                  title: 'Compétences',
                  action: isMe ? Icons.add : null,
                  onAction: () => _snack(context, 'Ajouter une compétence'),
                  child: Column(
                    children: [
                      for (var i = 0; i < user.skills.length; i++) ...[
                        if (i > 0) const Divider(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                user.skills[i],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              '${3 + i * 4} recommandations',
                              style: TextStyle(
                                fontSize: 12,
                                color: LiColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const LiBlockGap(),
              ],
              LiSectionCard(
                title: "Centres d'intérêt",
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    Chip(label: Text('Flutter Community')),
                    Chip(label: Text('Women Who Code')),
                    Chip(label: Text('UX Design')),
                    Chip(label: Text('Tech Africa')),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void _snack(BuildContext context, String msg) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(msg), duration: const Duration(milliseconds: 900)));
}

class _AnalyticsCard extends StatelessWidget {
  const _AnalyticsCard({required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return LiSectionCard(
      title: 'Analyses',
      child: Column(
        children: [
          _row(Icons.visibility_outlined,
              '${user.profileViews} vues du profil', 'Sur les 90 derniers jours'),
          const Divider(height: 20),
          _row(Icons.search,
              '${user.searchAppearances} apparitions dans les recherches',
              'Cette semaine'),
          const Divider(height: 20),
          _row(Icons.bar_chart,
              '${user.followers} abonnés', 'Développez votre audience'),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String title, String sub) => Row(
    children: [
      Icon(icon, size: 20, color: LiColors.textSecondary),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(sub,
                style: TextStyle(fontSize: 12, color: LiColors.textSecondary)),
          ],
        ),
      ),
    ],
  );
}

class _ActivitySection extends StatelessWidget {
  const _ActivitySection({
    required this.isMe,
    required this.name,
    required this.posts,
  });
  final bool isMe;
  final String name;
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return LiSectionCard(
      title: 'Activité',
      action: isMe ? Icons.edit_outlined : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isMe ? 'Vous · abonnés' : '$name a publié récemment',
            style: TextStyle(fontSize: 12, color: LiColors.textSecondary),
          ),
          const SizedBox(height: 8),
          if (isMe)
            OutlinedButton(
              onPressed: () => context.push('/create-post'),
              child: const Text('Créer un post'),
            ),
          if (posts.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Aucune publication pour le moment.',
                style: TextStyle(color: LiColors.textSecondary),
              ),
            )
          else
            for (final p in posts.take(3))
              InkWell(
                onTap: () => context.push('/post/${p.id}'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GenAvatar(seed: p.seed, name: p.author, size: 32),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.content,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${p.totalReactions} réactions · ${p.comments} commentaires',
                              style: TextStyle(
                                fontSize: 12,
                                color: LiColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          const SizedBox(height: 6),
          const Divider(height: 1),
          TextButton(
            onPressed: () {},
            child: const Text('Afficher toute l’activité'),
          ),
        ],
      ),
    );
  }
}

class _ExperienceTile extends StatelessWidget {
  const _ExperienceTile({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.description,
    this.icon = Icons.business_center,
  });
  final String role, company, period, location, description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: LiColors.canvas,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: LiColors.textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(company, style: const TextStyle(fontSize: 13)),
                Text(
                  period,
                  style: TextStyle(fontSize: 12, color: LiColors.textSecondary),
                ),
                if (location.isNotEmpty)
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 12,
                      color: LiColors.textSecondary,
                    ),
                  ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(fontSize: 13)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
