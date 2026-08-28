/// Retourne les initiales à afficher pour un profil local.
String getInitials(String firstName, String lastName) {
  final first = firstName.trim();
  final last = lastName.trim();

  final initials = [
    if (first.isNotEmpty) first[0],
    if (last.isNotEmpty) last[0],
  ].join();

  return initials.isEmpty ? '?' : initials.toUpperCase();
}
