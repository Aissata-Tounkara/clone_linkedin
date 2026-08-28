import 'package:flutter/material.dart';
import '../models/post.dart';
import '../widgets/avatar.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key, required this.post});
  final Post post;
  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final controller = TextEditingController();
  final _commentFocusNode = FocusNode();
  final comments = <String>[
    'Très belle initiative, merci pour le partage !',
    'Un sujet très intéressant.',
  ];
  @override
  void dispose() {
    controller.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  void addComment() {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      comments.add(text);
      widget.post.comments++;
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Scaffold(
      appBar: AppBar(title: const Text('Publication')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              InitialAvatar(
                initials: post.initials,
                colorValue: post.colorValue,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.author,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(post.role, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            post.content,
            style: const TextStyle(fontSize: 17, height: 1.45),
          ),
          if (post.visualLabel != null) ...[
            const SizedBox(height: 18),
            Container(
              height: 220,
              padding: const EdgeInsets.all(22),
              alignment: Alignment.bottomLeft,
              color: Color(post.colorValue),
              child: Text(
                post.visualLabel!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          const SizedBox(height: 18),
          Text(
            '${post.likes + (post.liked ? 1 : 0)} réactions · ${post.comments} commentaires',
          ),
          const Divider(height: 28),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 4,
            runSpacing: 4,
            children: [
              TextButton.icon(
                onPressed: () => setState(() => post.liked = !post.liked),
                icon: Icon(
                  post.liked ? Icons.thumb_up : Icons.thumb_up_outlined,
                ),
                label: const Text("J'aime"),
              ),
              TextButton.icon(
                onPressed: () =>
                    FocusScope.of(context).requestFocus(_commentFocusNode),
                icon: const Icon(Icons.comment_outlined),
                label: const Text('Commenter'),
              ),
              TextButton.icon(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Publication partagée (simulation)'),
                  ),
                ),
                icon: const Icon(Icons.share_outlined),
                label: const Text('Partager'),
              ),
            ],
          ),
          const Divider(),
          const Text(
            'Commentaires',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          ...comments.map(
            (comment) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CurrentUserAvatar(radius: 17),
              title: Text(comment),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: _commentFocusNode,
                  onSubmitted: (_) => addComment(),
                  decoration: InputDecoration(
                    hintText: 'Ajouter un commentaire',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: addComment,
                icon: const Icon(Icons.send),
                color: const Color(0xFF0A66C2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
