class Job {
  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    this.initials = '',
    this.colorValue = 0xFF0A66C2,
    this.postedAgo = 'il y a 1 j',
    this.applicants = 0,
    this.easyApply = true,
    this.promoted = false,
    this.activelyHiring = false,
    this.description = '',
    this.skills = const [],
    this.saved = false,
    this.applied = false,
  });

  final String id, title, company, location, type;
  final String initials, postedAgo, description;
  final int colorValue, applicants;
  final bool easyApply, promoted, activelyHiring;
  final List<String> skills;
  bool saved;
  bool applied;

  String get seed => 'c:$company';
}
