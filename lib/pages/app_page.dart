import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => _AppScaffold(
    title: 'Accueil',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Partager une publication'),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => context.go('/create-post'),
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Commencer un post'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        const _InfoCard(
          title: 'Bienvenue sur votre fil',
          message:
              'Cette maquette fonctionne uniquement côté interface. Les contenus affichés sont locaux.',
        ),
      ],
    ),
  );
}

class NetworkPage extends StatelessWidget {
  const NetworkPage({super.key});

  @override
  Widget build(BuildContext context) => const _AppScaffold(
    title: 'Mon réseau',
    child: _InfoCard(
      title: 'Développez votre réseau',
      message:
          'Les invitations et suggestions sont des données de démonstration.',
    ),
  );
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) => const _AppScaffold(
    title: 'Notifications',
    child: _InfoCard(
      title: 'Vous êtes à jour',
      message: 'Aucune nouvelle notification.',
    ),
  );
}

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) => const _AppScaffold(
    title: 'Emplois',
    child: _InfoCard(
      title: 'Recherchez un emploi',
      message: 'Les offres seront affichées ici dans une future version.',
    ),
  );
}

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _AppScaffold(
    title: 'Créer un post',
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              minLines: 5,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: 'De quoi souhaitez-vous parler ?',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                final message = _controller.text.trim().isEmpty
                    ? 'Écrivez un message avant de publier.'
                    : 'Publication simulée : aucune donnée n’est enregistrée.';
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              },
              child: const Text('Publier'),
            ),
          ],
        ),
      ),
    ),
  );
}

class _AppScaffold extends StatelessWidget {
  const _AppScaffold({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(title),
      actions: [
        IconButton(
          tooltip: 'Voir le profil',
          onPressed: () => context.go('/profile'),
          icon: const Icon(Icons.account_circle_outlined),
        ),
      ],
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: ListView(padding: const EdgeInsets.all(18), children: [child]),
      ),
    ),
  );
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.message});
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(message),
        ],
      ),
    ),
  );
}
