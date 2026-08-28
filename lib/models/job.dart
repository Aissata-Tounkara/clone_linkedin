class Job {
  const Job({
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.initials,
    required this.colorValue,
  });
  final String title, company, location, type, initials;
  final int colorValue;
}
