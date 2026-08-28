import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/repository.dart';
import '../state/current_user.dart';
import '../widgets/avatar.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final controller = TextEditingController();
  bool _attemptedPublish = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void publish() {
    final content = controller.text.trim();
    if (content.isEmpty) {
      setState(() => _attemptedPublish = true);
      return;
    }
    Repository.instance.addPost(content);
    context.go('/');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Publication créée')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Créer une publication'),
      actions: [
        AnimatedScale(
          scale: controller.text.trim().isEmpty ? 0.96 : 1,
          duration: const Duration(milliseconds: 160),
          child: TextButton(onPressed: publish, child: const Text('Publier')),
        ),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<CurrentUserProfile>(
            valueListenable: CurrentUser.profile,
            builder: (context, profile, _) => Row(
              children: [
                const CurrentUserAvatar(),
                const SizedBox(width: 10),
                Text(
                  profile.displayName.isEmpty
                      ? 'Utilisateur'
                      : profile.displayName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (_) => setState(() {}),
              autofocus: true,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                hintText: 'De quoi souhaitez-vous parler ?',
                border: InputBorder.none,
              ),
            ),
          ),
          if (_attemptedPublish && controller.text.trim().isEmpty)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Écrivez un message avant de publier.',
                style: TextStyle(color: Colors.red),
              ),
            ),
          const Divider(),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 4,
            runSpacing: 4,
            children: [
              _PostOption(
                icon: Icons.image_outlined,
                label: 'Photo',
                onPressed: () => _showUnavailable('Photo'),
              ),
              _PostOption(
                icon: Icons.videocam_outlined,
                label: 'Vidéo',
                onPressed: () => _showUnavailable('Vidéo'),
              ),
              _PostOption(
                icon: Icons.description_outlined,
                label: 'Document',
                onPressed: () => _showUnavailable('Document'),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  void _showUnavailable(String label) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text('$label ajouté (simulation)')));
}

class _PostOption extends StatelessWidget {
  const _PostOption({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => TextButton.icon(
    onPressed: onPressed,
    icon: Icon(icon),
    label: Text(label),
  );
}
