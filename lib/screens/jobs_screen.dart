import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repository.dart';
import '../widgets/avatar.dart';
import '../widgets/empty_state.dart';
import '../widgets/job_card.dart';
import '../widgets/li_widgets.dart';
import '../theme/app_tokens.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final _repo = Repository.instance;
  String _query = '';
  String _chip = 'Recommandés';

  static const _chips = [
    'Recommandés',
    'Mes emplois',
    'Candidature simplifiée',
    'À distance',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => context.push('/profile'),
              child: const CurrentUserAvatar(radius: 16),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: LiColors.searchField,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search,
                        size: 20, color: LiColors.textSecondary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: (v) => setState(() => _query = v),
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: 'Rechercher un poste',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: AnimatedBuilder(
        animation: _repo,
        builder: (context, _) {
          final all = _chip == 'Mes emplois'
              ? [..._repo.savedJobs, ..._repo.appliedJobs]
              : _repo.jobs;
          final jobs = all
              .where((j) =>
                  '${j.title} ${j.company}'
                      .toLowerCase()
                      .contains(_query.toLowerCase()) &&
                  (_chip != 'Candidature simplifiée' || j.easyApply) &&
                  (_chip != 'À distance' ||
                      j.location.toLowerCase().contains('distance') ||
                      j.location.toLowerCase().contains('télétravail') ||
                      j.location.toLowerCase().contains('remote')))
              .toSet()
              .toList();
          return Column(
            children: [
              LiChipsRow(
                options: _chips,
                selected: _chip,
                onSelected: (v) => setState(() => _chip = v),
              ),
              const Divider(height: 1),
              Container(
                width: double.infinity,
                color: LiColors.surface,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Text(
                  _chip == 'Mes emplois'
                      ? 'Emplois enregistrés et candidatures'
                      : 'Offres recommandées pour vous',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: jobs.isEmpty
                    ? const EmptyState(
                        icon: Icons.work_off_outlined,
                        title: 'Aucune offre',
                        message: 'Modifiez votre recherche ou vos filtres.',
                      )
                    : Container(
                        color: LiColors.surface,
                        child: ListView.separated(
                          itemCount: jobs.length,
                          separatorBuilder: (_, _) =>
                              const Divider(height: 1, indent: 76),
                          itemBuilder: (_, i) => JobCard(
                            job: jobs[i],
                            onOpen: () => context.push('/job/${jobs[i].id}'),
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
