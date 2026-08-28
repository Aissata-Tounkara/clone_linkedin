import 'package:flutter/material.dart';
import '../models/job.dart';
import 'avatar.dart';

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.job, required this.onView});
  final Job job;
  final VoidCallback onView;
  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InitialAvatar(initials: job.initials, colorValue: job.colorValue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 3),
                Text(job.company),
                Text(
                  job.location,
                  style: const TextStyle(color: Color(0xFF666666)),
                ),
                const SizedBox(height: 8),
                Chip(
                  label: Text(job.type),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          OutlinedButton(onPressed: onView, child: const Text("Voir l'offre")),
        ],
      ),
    ),
  );
}
