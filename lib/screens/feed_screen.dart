import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/local_data.dart';
import '../models/post.dart';
import '../widgets/avatar.dart';
import '../widgets/post_card.dart';
import '../widgets/responsive_content.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  void _message(String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  void _comments(Post post) => showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (_) => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Commentaires', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const Text('Soyez le premier à partager votre avis.'),
          const SizedBox(height: 18),
          TextField(
            decoration: InputDecoration(
              hintText: 'Ajouter un commentaire',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      titleSpacing: 14,
      title: InkWell(
        onTap: () => context.go('/search'),
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFEDF3F8),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Row(
            children: [
              Icon(Icons.search, color: Color(0xFF536471)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Rechercher',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, color: Color(0xFF536471)),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => context.push('/messaging'),
          icon: const Icon(Icons.chat_bubble_outline, color: Color(0xFF1F1F1F)),
        ),
        PopupMenuButton<String>(
          onSelected: (route) => context.push(route),
          itemBuilder: (_) => const [
            PopupMenuItem(value: '/profile', child: Text('Profil')),
            PopupMenuItem(value: '/jobs', child: Text('Emplois')),
            PopupMenuItem(
              value: '/notifications',
              child: Text('Notifications'),
            ),
          ],
        ),
      ],
    ),
    body: ListView.builder(
      itemCount: LocalData.posts.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ResponsiveContent(
            child: _Composer(onMessage: () => context.push('/create-post')),
          );
        }
        final post = LocalData.posts[index - 1];
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 220 + index * 70),
          curve: Curves.easeOut,
          builder: (context, value, child) => Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 12 * (1 - value)),
              child: child,
            ),
          ),
          child: ResponsiveContent(
            child: PostCard(
              post: post,
              onTap: () => context.push('/post/${post.id}'),
              onLike: () => setState(() => post.liked = !post.liked),
              onComment: () => _comments(post),
              onShare: () => _message('Publication partagée (simulation)'),
            ),
          ),
        );
      },
    ),
  );
}

class _Composer extends StatelessWidget {
  const _Composer({required this.onMessage});
  final VoidCallback onMessage;

  @override
  Widget build(BuildContext context) => Container(
    color: Theme.of(context).colorScheme.surface,
    margin: const EdgeInsets.only(bottom: 9),
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
    child: Column(
      children: [
        Row(
          children: [
            const CurrentUserAvatar(),
            const SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: onMessage,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF777777)),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    'Commencer un post',
                    style: TextStyle(color: Color(0xFF555555)),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Wrap(
          alignment: WrapAlignment.spaceAround,
          runSpacing: 6,
          children: [
            _ComposerAction(
              icon: Icons.image_outlined,
              label: 'Photo',
              color: Color(0xFF378FE9),
            ),
            _ComposerAction(
              icon: Icons.videocam_outlined,
              label: 'Vidéo',
              color: Color(0xFF5F9B41),
            ),
            _ComposerAction(
              icon: Icons.article_outlined,
              label: 'Article',
              color: Color(0xFFE16745),
            ),
          ],
        ),
      ],
    ),
  );
}

class _ComposerAction extends StatelessWidget {
  const _ComposerAction({
    required this.icon,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: color),
      const SizedBox(width: 5),
      Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    ],
  );
}
