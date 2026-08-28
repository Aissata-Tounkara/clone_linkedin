import 'package:flutter/material.dart';
import '../models/post.dart';
import '../screens/post_detail_screen.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) => PostDetailScreen(post: post);
}
