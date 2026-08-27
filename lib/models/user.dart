class User {
  const User({
    required this.id,
    required this.name,
    required this.headline,
    required this.initials,
    required this.colorValue,
    this.location = '',
  });
  final String id, name, headline, initials, location;
  final int colorValue;
}
