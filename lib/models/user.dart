/// Profil d'une personne (moi ou une relation). Tout est en mémoire.
class Experience {
  const Experience({
    required this.role,
    required this.company,
    required this.period,
    this.location = '',
    this.description = '',
  });
  final String role, company, period, location, description;
}

class Education {
  const Education({
    required this.school,
    required this.degree,
    required this.period,
  });
  final String school, degree, period;
}

class User {
  const User({
    required this.id,
    required this.name,
    required this.headline,
    this.initials = '',
    this.colorValue = 0xFF0A66C2,
    this.location = '',
    this.degree = '2e',
    this.mutuals = 0,
    this.company = '',
    this.school = '',
    this.about = '',
    this.pronouns = '',
    this.followers = 0,
    this.profileViews = 0,
    this.searchAppearances = 0,
    this.connectionsCount = 0,
    this.experiences = const [],
    this.educations = const [],
    this.skills = const [],
  });

  final String id, name, headline, initials, location, degree;
  final String company, school, about, pronouns;
  final int colorValue, mutuals, followers, profileViews, searchAppearances;
  final int connectionsCount;
  final List<Experience> experiences;
  final List<Education> educations;
  final List<String> skills;

  /// Seed stable pour l'avatar/bannière générés.
  String get seed => 'u:$id';
}
