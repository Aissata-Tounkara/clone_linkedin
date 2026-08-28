import 'package:flutter/material.dart';
import '../models/post.dart';
import '../theme/app_theme.dart';
import 'avatar.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.onTap,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });
  final Post post;
  final VoidCallback onTap, onLike, onComment, onShare;
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 9),
    elevation: 0,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InitialAvatar(
                  initials: post.initials,
                  colorValue: post.colorValue,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        post.role,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${post.time} · 🌐',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz, color: AppColors.mutedText),
              ],
            ),
            const SizedBox(height: 12),
            Text(post.content, style: const TextStyle(height: 1.35)),
            if (post.visualLabel != null) ...[
              const SizedBox(height: 13),
              Container(
                width: double.infinity,
                height: 150,
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(18),
                color: Color(post.colorValue),
                child: Text(
                  post.visualLabel!,
                  style: const TextStyle(
                    fontSize: 25,
                    height: 1.05,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.thumb_up, size: 16, color: AppColors.blue),
                const SizedBox(width: 4),
                Text('${post.likes + (post.liked ? 1 : 0)}'),
                const Spacer(),
                Text('${post.comments} commentaires'),
              ],
            ),
            const Divider(height: 18),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              runSpacing: 2,
              children: [
                _Action(
                  icon: post.liked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  label: "J'aime",
                  active: post.liked,
                  onTap: onLike,
                ),
                _Action(
                  icon: Icons.mode_comment_outlined,
                  label: 'Commenter',
                  onTap: onComment,
                ),
                _Action(
                  icon: Icons.share_outlined,
                  label: 'Partager',
                  onTap: onShare,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class _Action extends StatelessWidget {
  const _Action({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(5),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: [
          AnimatedScale(
            scale: active ? 1.18 : 1,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutBack,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 160),
              child: Icon(
                icon,
                key: ValueKey(icon),
                size: 20,
                color: active ? AppColors.blue : AppColors.mutedText,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: active ? AppColors.blue : AppColors.mutedText,
            ),
          ),
        ],
      ),
    ),
  );
}
