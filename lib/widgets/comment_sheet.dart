import 'package:flutter/material.dart';

import '../data/repository.dart';
import '../data/seed_data.dart';
import '../models/comment.dart';
import '../models/post.dart';
import '../theme/app_tokens.dart';
import 'avatar.dart';
import 'gen_avatar.dart';

/// Affiche les commentaires d'une publication dans une feuille modale, comme
/// sur LinkedIn (tri, réponses imbriquées, composeur épinglé en bas).
Future<void> showCommentsSheet(BuildContext context, Post post) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: CommentsView(post: post),
      ),
    ),
  );
}

class CommentsView extends StatefulWidget {
  const CommentsView({super.key, required this.post, this.showHeader = true});
  final Post post;
  final bool showHeader;

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  Comment? _replyTo;

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    Repository.instance.addComment(widget.post, text, parent: _replyTo);
    _controller.clear();
    setState(() => _replyTo = null);
    _focus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Repository.instance,
      builder: (context, _) {
        final comments = widget.post.commentList;
        return Column(
          children: [
            if (widget.showHeader) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const SizedBox(width: 16),
                  Text(
                    'Commentaires',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Text('Les plus pertinents'),
                    label: const Icon(Icons.keyboard_arrow_down, size: 18),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              const Divider(height: 1),
            ],
            Expanded(
              child: comments.isEmpty
                  ? const _NoComments()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: comments.length,
                      itemBuilder: (_, i) => _CommentTile(
                        comment: comments[i],
                        onReply: (c) {
                          setState(() => _replyTo = c);
                          _focus.requestFocus();
                        },
                      ),
                    ),
            ),
            _Composer(
              controller: _controller,
              focusNode: _focus,
              replyingTo: _replyTo == null
                  ? null
                  : Seed.user(_replyTo!.authorId).name,
              onCancelReply: () => setState(() => _replyTo = null),
              onSend: _send,
            ),
          ],
        );
      },
    );
  }
}

class _NoComments extends StatelessWidget {
  const _NoComments();
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.mode_comment_outlined,
              size: 40, color: LiColors.textTertiary),
          const SizedBox(height: 10),
          Text(
            'Aucun commentaire pour le moment.',
            style: TextStyle(color: LiColors.textSecondary),
          ),
          const Text('Soyez la première personne à réagir.'),
        ],
      ),
    ),
  );
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment, required this.onReply, this.inset = 0});
  final Comment comment;
  final ValueChanged<Comment> onReply;
  final double inset;

  @override
  Widget build(BuildContext context) {
    final author = comment.authorId == 'me'
        ? Repository.instance.me
        : Seed.user(comment.authorId);
    final seed = comment.authorId == 'me'
        ? Repository.instance.mySeed
        : author.seed;
    return Padding(
      padding: EdgeInsets.fromLTRB(16 + inset, 8, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GenAvatar(seed: seed, name: author.name, size: inset > 0 ? 28 : 36),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
                  decoration: BoxDecoration(
                    color: LiColors.bubbleIn,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              author.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          if (comment.isAuthor) ...[
                            const SizedBox(width: 6),
                            Text(
                              '• Auteur',
                              style: TextStyle(
                                fontSize: 11,
                                color: LiColors.textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        author.headline,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: LiColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(comment.text, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: inset > 0 ? 36 : 44, top: 2),
            child: Row(
              children: [
                Text(comment.time,
                    style: TextStyle(
                        fontSize: 12, color: LiColors.textTertiary)),
                _dot(),
                InkWell(
                  onTap: () => Repository.instance.toggleCommentLike(comment),
                  child: Text(
                    "J'aime${comment.likes > 0 ? ' · ${comment.likes}' : ''}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: comment.liked
                          ? LiColors.brand
                          : LiColors.textSecondary,
                    ),
                  ),
                ),
                if (inset == 0) ...[
                  _dot(),
                  InkWell(
                    onTap: () => onReply(comment),
                    child: Text(
                      'Répondre',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: LiColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          for (final reply in comment.replies)
            _CommentTile(comment: reply, onReply: onReply, inset: 28),
        ],
      ),
    );
  }

  Widget _dot() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Text('·', style: TextStyle(color: LiColors.textTertiary)),
  );
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.focusNode,
    required this.onSend,
    required this.onCancelReply,
    this.replyingTo,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSend;
  final VoidCallback onCancelReply;
  final String? replyingTo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: LiColors.hairline)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (replyingTo != null)
              Container(
                width: double.infinity,
                color: LiColors.canvas,
                padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'En réponse à $replyingTo',
                        style: TextStyle(
                          fontSize: 12,
                          color: LiColors.textSecondary,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onCancelReply,
                      child: const Icon(Icons.close, size: 16),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
              child: Row(
                children: [
                  const CurrentUserAvatar(radius: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      minLines: 1,
                      maxLines: 4,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => onSend(),
                      decoration: InputDecoration(
                        hintText: 'Ajouter un commentaire…',
                        isDense: true,
                        filled: true,
                        fillColor: LiColors.surface,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: LiColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: LiColors.border),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onSend,
                    icon: const Icon(Icons.send, color: LiColors.brand),
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
