import 'package:flutter/material.dart';

import '../data/repository.dart';
import '../models/post.dart';
import '../theme/app_tokens.dart';
import 'comment_sheet.dart';
import 'gen_avatar.dart';
import 'li_widgets.dart';
import 'reaction_bar.dart';

/// Carte de publication du fil, calée sur LinkedIn mobile :
/// en-tête auteur + suivre, texte tronqué « …voir plus », média
/// (image / article / document / sondage), preuve sociale, barre d'action
/// avec réactions à l'appui long.
class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.post,
    this.onOpenPost,
    this.onOpenAuthor,
  });
  final Post post;
  final VoidCallback? onOpenPost;
  final VoidCallback? onOpenAuthor;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _expanded = false;
  final _likeKey = GlobalKey();

  Post get post => widget.post;
  Repository get repo => Repository.instance;

  void _openReactions() {
    final box = _likeKey.currentContext?.findRenderObject() as RenderBox?;
    final anchor = box == null
        ? const Offset(40, 300)
        : box.localToGlobal(box.size.centerLeft(Offset.zero));
    ReactionBar.show(
      context,
      anchor: anchor,
      onPick: (r) => repo.toggleReaction(post, r),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: repo,
      builder: (context, _) {
        return Container(
          color: LiColors.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              _body(context),
              _media(context),
              const SizedBox(height: 8),
              _socialProof(context),
              const Divider(height: 1, indent: 12, endIndent: 12),
              _actions(context),
            ],
          ),
        );
      },
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 6, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.onOpenAuthor,
            child: GenAvatar(seed: post.seed, name: post.author, size: 48),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: widget.onOpenAuthor,
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          post.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (post.isConnection)
                        Text(
                          ' · 1er',
                          style: TextStyle(
                            fontSize: 12,
                            color: LiColors.textTertiary,
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  post.role,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: LiColors.textSecondary),
                ),
                Row(
                  children: [
                    Text(
                      post.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: LiColors.textTertiary,
                      ),
                    ),
                    Text(' · ',
                        style: TextStyle(color: LiColors.textTertiary)),
                    Icon(Icons.public, size: 12, color: LiColors.textTertiary),
                  ],
                ),
              ],
            ),
          ),
          if (!post.isConnection && post.authorId != 'me')
            TextButton.icon(
              onPressed: () => repo.toggleFollow(post),
              icon: Icon(
                post.following ? Icons.check : Icons.add,
                size: 18,
                color: post.following ? LiColors.textSecondary : LiColors.brand,
              ),
              label: Text(
                post.following ? 'Suivi' : 'Suivre',
                style: TextStyle(
                  color:
                      post.following ? LiColors.textSecondary : LiColors.brand,
                ),
              ),
            ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () => showLiOverflowSheet(
              context,
              items: const [
                (icon: Icons.bookmark_border, label: 'Enregistrer'),
                (icon: Icons.notifications_off_outlined, label: 'Me désabonner'),
                (icon: Icons.visibility_off_outlined, label: 'Masquer ce post'),
                (icon: Icons.flag_outlined, label: 'Signaler la publication'),
              ],
            ),
            icon: Icon(Icons.more_horiz, color: LiColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    final text = post.content;
    final isLong = text.length > 220 || '\n'.allMatches(text).length > 2;
    final truncated = isLong && !_expanded;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: GestureDetector(
        onTap: truncated
            ? () => setState(() => _expanded = true)
            : widget.onOpenPost,
        child: AnimatedSize(
          duration: LiDuration.fast,
          alignment: Alignment.topCenter,
          child: Text.rich(
            TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(
                fontSize: 14,
                height: 1.4,
                color: LiColors.textPrimary,
              ),
              children: [
                ..._spans(
                  truncated
                      ? '${text.substring(0, 200).trimRight()}… '
                      : text,
                ),
                if (truncated)
                  TextSpan(
                    text: 'voir plus',
                    style: TextStyle(color: LiColors.textSecondary),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<InlineSpan> _spans(String text) {
    // Colore les hashtags en bleu.
    final spans = <InlineSpan>[];
    final regex = RegExp(r'(#[\wÀ-ÿ]+)');
    var start = 0;
    for (final m in regex.allMatches(text)) {
      if (m.start > start) {
        spans.add(TextSpan(text: text.substring(start, m.start)));
      }
      spans.add(
        TextSpan(
          text: m.group(0),
          style: const TextStyle(
            color: LiColors.brand,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
      start = m.end;
    }
    if (start < text.length) spans.add(TextSpan(text: text.substring(start)));
    return spans;
  }

  Widget _media(BuildContext context) {
    switch (post.media) {
      case PostMedia.none:
        return const SizedBox.shrink();
      case PostMedia.image:
        return GestureDetector(
          onTap: widget.onOpenPost,
          child: GenBanner(seed: post.imageSeed ?? post.id, height: 220),
        );
      case PostMedia.article:
        return InkWell(
          onTap: widget.onOpenPost,
          child: Container(
            color: LiColors.bubbleIn,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GenBanner(seed: post.articleTitle ?? post.id, height: 160),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.articleTitle ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        post.articleDomain ?? '',
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
        );
      case PostMedia.document:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF283E4A),
            borderRadius: BorderRadius.circular(4),
          ),
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.description, color: Colors.white, size: 48),
              const SizedBox(height: 8),
              Text(
                post.documentTitle ?? 'Document',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                '${post.documentPages ?? 1} pages',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        );
      case PostMedia.poll:
        return _Poll(post: post);
    }
  }

  Widget _socialProof(BuildContext context) {
    final total = post.totalReactions;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
      child: Row(
        children: [
          ReactionStack(reactions: post.topReactions),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              total == 0 ? 'Soyez la première réaction' : '$total',
              style: TextStyle(fontSize: 12, color: LiColors.textSecondary),
            ),
          ),
          if (post.comments > 0)
            Text(
              '${post.comments} commentaire${post.comments > 1 ? 's' : ''}',
              style: TextStyle(fontSize: 12, color: LiColors.textSecondary),
            ),
          if (post.comments > 0 && post.reposts > 0)
            Text(' · ', style: TextStyle(color: LiColors.textTertiary)),
          if (post.reposts > 0)
            Text(
              '${post.reposts} republication${post.reposts > 1 ? 's' : ''}',
              style: TextStyle(fontSize: 12, color: LiColors.textSecondary),
            ),
        ],
      ),
    );
  }

  Widget _actions(BuildContext context) {
    final r = post.myReaction;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        children: [
          LiIconAction(
            key: _likeKey,
            icon: r?.icon ?? Icons.thumb_up_outlined,
            label: r?.label ?? "J'aime",
            active: r != null,
            color: r?.color,
            onTap: () => repo.toggleReaction(post, r ?? LiReaction.like),
            onLongPress: _openReactions,
          ),
          LiIconAction(
            icon: Icons.mode_comment_outlined,
            label: 'Commenter',
            onTap: () => showCommentsSheet(context, post),
          ),
          LiIconAction(
            icon: Icons.repeat,
            label: 'Republier',
            onTap: () => showLiOverflowSheet(
              context,
              items: const [
                (icon: Icons.repeat, label: 'Republier tel quel'),
                (icon: Icons.edit_outlined, label: 'Republier avec vos idées'),
              ],
            ),
          ),
          LiIconAction(
            icon: Icons.send_outlined,
            label: 'Envoyer',
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Partagé en message (simulation)'),
                duration: Duration(milliseconds: 900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Poll extends StatelessWidget {
  const _Poll({required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    final total = post.pollOptions.fold<int>(0, (a, o) => a + o.votes);
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: LiColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          for (var i = 0; i < post.pollOptions.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _PollOptionBar(
                label: post.pollOptions[i].label,
                votes: post.pollOptions[i].votes,
                total: total,
                onTap: () => Repository.instance.votePoll(post, i),
              ),
            ),
          Text(
            '$total votes · 3 j restants',
            style: TextStyle(fontSize: 12, color: LiColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _PollOptionBar extends StatelessWidget {
  const _PollOptionBar({
    required this.label,
    required this.votes,
    required this.total,
    required this.onTap,
  });
  final String label;
  final int votes;
  final int total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final pct = total == 0 ? 0.0 : votes / total;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Container(
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: LiColors.brand),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          FractionallySizedBox(
            widthFactor: pct.clamp(0.0, 1.0),
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: LiColors.brandTint,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    '${(pct * 100).round()} %',
                    style: TextStyle(
                      fontSize: 12,
                      color: LiColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
