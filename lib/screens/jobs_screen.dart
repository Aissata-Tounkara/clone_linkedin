import 'package:flutter/material.dart';
import '../data/local_data.dart';
import '../models/job.dart';
import '../widgets/empty_state.dart';
import '../widgets/job_card.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});
  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  String query = '';
  String _filter = 'Tous';

  bool _matchesFilter(Job job) => switch (_filter) {
    'À distance' => job.location.contains('distance'),
    'CDI' => job.type == 'CDI',
    'Date de publication' => job.title.contains('Flutter'),
    _ => true,
  };

  void _selectFilter(String value) => setState(() => _filter = value);

  @override
  Widget build(BuildContext context) {
    final jobs = LocalData.jobs
        .where(
          (job) =>
              '${job.title} ${job.company}'.toLowerCase().contains(
                query.toLowerCase(),
              ) &&
              _matchesFilter(job),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: TextField(
          onChanged: (value) => setState(() => query = value),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Décrivez l’emploi que vous recherchez',
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Color(0xFFB0B0B0)),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 108,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final filter in const [
                      'Préférences',
                      'À distance',
                      'Suivi des emplois',
                      'Publier une offre d’emploi gratuite',
                      'Tous',
                      'CDI',
                    ])
                      ChoiceChip(
                        label: Text(filter),
                        selected: _filter == filter,
                        onSelected: (_) => _selectFilter(filter),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: jobs.isEmpty
                ? const EmptyState(
                    icon: Icons.work_off_outlined,
                    title: 'Aucun emploi trouvé',
                    message: 'Modifiez votre recherche ou vos filtres.',
                  )
                : ListView.builder(
                    itemCount: jobs.length,
                    itemBuilder: (_, index) => JobCard(
                      job: jobs[index],
                      onView: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Offre ${jobs[index].title} ouverte (simulation)',
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
