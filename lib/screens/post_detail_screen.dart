import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repository.dart';
import '../models/post.dart';
import '../widgets/comment_sheet.dart';
import '../widgets/post_card.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publication'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_border),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: Repository.instance,
        builder: (context, _) => Column(
          children: [
            PostCard(
              post: post,
              onOpenAuthor: () => post.authorId == 'me'
                  ? context.push('/profile')
                  : context.push('/u/${post.authorId}'),
            ),
            const Divider(height: 1),
            Expanded(
              child: CommentsView(post: post, showHeader: false),
            ),
          ],
        ),
      ),
    );
  }
}
