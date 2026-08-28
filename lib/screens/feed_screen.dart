import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repository.dart';
import '../theme/app_tokens.dart';
import '../widgets/avatar.dart';
import '../widgets/li_widgets.dart';
import '../widgets/me_panel.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _scroll = ScrollController();
  final _repo = Repository.instance;
  bool _loadingMore = false;
  int _visible = 6;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels >
        _scroll.position.maxScrollExtent - 600) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_loadingMore) return;
    if (_visible >= _repo.feed.length + 20) return;
    setState(() => _loadingMore = true);
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (_visible >= _repo.feed.length) _repo.loadMore();
    if (!mounted) return;
    setState(() {
      _visible += 5;
      _loadingMore = false;
    });
  }

  Future<void> _refresh() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (mounted) setState(() => _visible = 6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MePanel(),
      appBar: _FeedAppBar(repo: _repo),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: AnimatedBuilder(
          animation: _repo,
          builder: (context, _) {
            final posts = _repo.feed;
            final count = _visible.clamp(0, posts.length);
            return ListView.builder(
              controller: _scroll,
              padding: EdgeInsets.zero,
              itemCount: count + 3,
              itemBuilder: (context, index) {
                if (index == 0) return const _Composer();
                if (index == 1) return const LiSortHeader();
                final postIndex = index - 2;
                if (postIndex < count) {
                  return Column(
                    children: [
                      PostCard(
                        post: posts[postIndex],
                        onOpenPost: () =>
                            context.push('/post/${posts[postIndex].id}'),
                        onOpenAuthor: () => _openAuthor(posts[postIndex].authorId),
                      ),
                      const LiBlockGap(),
                    ],
                  );
                }
                // pied de liste
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: _loadingMore
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            'Vous êtes à jour 🎉',
                            style: TextStyle(color: LiColors.textSecondary),
                          ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _openAuthor(String id) {
    if (id.isEmpty) return;
    context.push(id == 'me' ? '/profile' : '/u/$id');
  }
}

class _FeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _FeedAppBar({required this.repo});
  final Repository repo;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 8,
      title: Row(
        children: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: const CurrentUserAvatar(radius: 16),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => context.push('/search'),
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: LiColors.searchField,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, size: 20, color: LiColors.textSecondary),
                    const SizedBox(width: 8),
                    Text(
                      'Rechercher',
                      style: TextStyle(color: LiColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: repo,
            builder: (context, _) => IconButton(
              onPressed: () => context.push('/messaging'),
              icon: LiBadge(
                count: repo.unreadMessages,
                child: const Icon(Icons.chat_bubble_outline),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LiColors.surface,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      child: Column(
        children: [
          Row(
            children: [
              const CurrentUserAvatar(radius: 18),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push('/create-post'),
                  child: Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: LiColors.textTertiary),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      'Créer un post',
                      style: TextStyle(color: LiColors.textSecondary),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _ComposerAction(
                icon: Icons.image,
                label: 'Photo',
                color: Color(0xFF378FE9),
              ),
              _ComposerAction(
                icon: Icons.smart_display,
                label: 'Vidéo',
                color: Color(0xFF5F9B41),
              ),
              _ComposerAction(
                icon: Icons.article,
                label: 'Rédiger un article',
                color: Color(0xFFE06847),
              ),
            ],
          ),
        ],
      ),
    );
  }
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
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => context.push('/create-post'),
      icon: Icon(icon, color: color, size: 20),
      label: Text(
        label,
        style: TextStyle(
          color: LiColors.textSecondary,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}
