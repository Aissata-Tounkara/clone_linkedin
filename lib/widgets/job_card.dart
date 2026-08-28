import 'package:flutter/material.dart';

import '../data/repository.dart';
import '../models/job.dart';
import '../theme/app_tokens.dart';
import 'gen_avatar.dart';

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.job, required this.onOpen});
  final Job job;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onOpen,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GenAvatar(
              seed: job.seed,
              name: job.company,
              size: 48,
              shape: AvatarShape.roundedSquare,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: LiColors.brandHover,
                    ),
                  ),
                  Text(job.company, style: const TextStyle(fontSize: 14)),
                  Text(
                    job.location,
                    style: TextStyle(
                      fontSize: 13,
                      color: LiColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (job.activelyHiring)
                    Row(
                      children: [
                        Icon(Icons.verified,
                            size: 14, color: LiColors.greenDark),
                        const SizedBox(width: 4),
                        Text(
                          "L'entreprise recrute activement",
                          style: TextStyle(
                            fontSize: 12,
                            color: LiColors.greenDark,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      if (job.easyApply) ...[
                        const Icon(Icons.check_circle,
                            size: 13, color: LiColors.brand),
                        const SizedBox(width: 3),
                        Text(
                          'Candidature simplifiée',
                          style: TextStyle(
                            fontSize: 12,
                            color: LiColors.textSecondary,
                          ),
                        ),
                        Text(' · ',
                            style: TextStyle(color: LiColors.textTertiary)),
                      ],
                      Text(
                        job.promoted ? 'Promu' : job.postedAgo,
                        style: TextStyle(
                          fontSize: 12,
                          color: LiColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: Repository.instance,
              builder: (context, _) => IconButton(
                onPressed: () => Repository.instance.toggleSaveJob(job),
                icon: Icon(
                  job.saved ? Icons.bookmark : Icons.bookmark_border,
                  color: job.saved ? LiColors.brand : LiColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
