import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/responsive_content.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 245,
          title: const Text('Profil'),
          flexibleSpace: FlexibleSpaceBar(
            background: const ProfileHeader(
              name: 'Alpha Ousmane BAH',
              headline: 'Développeur full-stack · web-mobile',
              initials: 'AB',
              colorValue: 0xFF174E85,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ResponsiveContent(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 26),
                  Text(
                    'Alpha Ousmane BAH',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('Développeur full-stack'),
                  const SizedBox(height: 4),
                  const Text(
                    'Guinnée · Conakry · Coordonnées',
                    style: TextStyle(color: Color(0xFF666666)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '503 relations',
                    style: TextStyle(
                      color: Color(0xFF0A66C2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 13),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilledButton(
                        onPressed: () =>
                            _feedback(context, 'Invitation envoyée'),
                        child: const Text('Ajouter'),
                      ),
                      OutlinedButton(
                        onPressed: () =>
                            _feedback(context, 'Ouverture de la messagerie'),
                        child: const Text('Message'),
                      ),
                      OutlinedButton(
                        onPressed: () => _feedback(
                          context,
                          'Modification du profil simulée',
                        ),
                        child: const Text('Modifier'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _Section(
                    title: 'À propos',
                    child: const Text(
                      'Développeur full-stack · ReactJs · MongoDB · NodeJS · PHP-Laravel · HTML-CSS ',
                    ),
                  ),
                  _Section(
                    title: 'Expérience',
                    child: const _Timeline(
                      items: [
                        'Développeure Laravel · IST-MAMOU',
                        'Confection des logos professionnel',
                      ],
                    ),
                  ),
                  _Section(
                    title: 'Formations',
                    child: const _Timeline(
                      items: [
                        'Licence professionel en Génie Informatique',
                        'Certification Flutter & Dart',
                        'Certificat developpeur web avec Simplon',
                        'Certificat developpeur mobile avec D-CLIC',
                      ],
                    ),
                  ),
                  _Section(
                    title: 'Compétences',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [
                        Chip(label: Text('Flutter')),
                        Chip(label: Text('Dart')),
                        Chip(label: Text('UI Design')),
                        Chip(label: Text('Git')),
                        Chip(label: Text('HTML-CSS')),
                        Chip(label: Text('PHP-Laravel')),
                        Chip(label: Text('NodeJs')),
                        Chip(label: Text('MongoDB')),
                      ],
                    ),
                  ),
                  _Section(
                    title: "Centres d'intérêt",
                    child: Wrap(
                      spacing: 8,
                      children: const [
                        Chip(label: Text('Mobile')),
                        Chip(label: Text('Web')),
                        Chip(label: Text('Design produit')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

void _feedback(BuildContext context, String message) => ScaffoldMessenger.of(
  context,
).showSnackBar(SnackBar(content: Text(message)));

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 10),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    ),
  );
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.items});
  final List<String> items;
  @override
  Widget build(BuildContext context) => Column(
    children: items
        .map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                const Icon(Icons.work_outline, color: Color(0xFF0A66C2)),
                const SizedBox(width: 10),
                Expanded(child: Text(item)),
              ],
            ),
          ),
        )
        .toList(),
  );
}
