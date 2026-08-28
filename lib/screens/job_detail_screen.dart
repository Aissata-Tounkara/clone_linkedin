import 'package:flutter/material.dart';

import '../data/repository.dart';
import '../models/job.dart';
import '../theme/app_tokens.dart';
import '../widgets/gen_avatar.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key, required this.job});
  final Job job;

  @override
  Widget build(BuildContext context) {
    final repo = Repository.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offre d’emploi'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
        ],
      ),
      body: AnimatedBuilder(
        animation: repo,
        builder: (context, _) => ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: LiColors.surface,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      GenAvatar(
                        seed: job.seed,
                        name: job.company,
                        size: 28,
                        shape: AvatarShape.roundedSquare,
                      ),
                      const SizedBox(width: 8),
                      Text(job.company,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${job.location} · ${job.postedAgo} · ${job.applicants} candidats',
                    style: TextStyle(
                        fontSize: 13, color: LiColors.textSecondary),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(
                        label: Text(job.type),
                        visualDensity: VisualDensity.compact,
                      ),
                      if (job.easyApply)
                        Chip(
                          avatar: const Icon(Icons.check_circle,
                              size: 16, color: LiColors.brand),
                          label: const Text('Candidature simplifiée'),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: job.applied
                              ? null
                              : () {
                                  repo.applyToJob(job);
                                  _applied(context);
                                },
                          child: Text(
                            job.applied
                                ? 'Candidature envoyée'
                                : 'Candidature simplifiée',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () => repo.toggleSaveJob(job),
                        icon: Icon(
                          job.saved ? Icons.bookmark : Icons.bookmark_border,
                        ),
                        label: Text(job.saved ? 'Enregistré' : 'Enregistrer'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              color: LiColors.surface,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('À propos du poste',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(job.description, style: const TextStyle(height: 1.45)),
                  if (job.skills.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text('Compétences',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final s in job.skills) Chip(label: Text(s)),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              color: LiColors.surface,
              child: ListTile(
                leading: GenAvatar(
                  seed: job.seed,
                  name: job.company,
                  size: 40,
                  shape: AvatarShape.roundedSquare,
                ),
                title: Text(job.company,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Voir la page de l’entreprise'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _applied(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: LiColors.greenDark, size: 48),
            const SizedBox(height: 12),
            Text(
              'Candidature envoyée à ${job.company}',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Vous recevrez une réponse par messagerie (simulation).',
              textAlign: TextAlign.center,
              style: TextStyle(color: LiColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
