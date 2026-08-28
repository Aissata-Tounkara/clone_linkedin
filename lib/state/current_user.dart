import 'package:flutter/foundation.dart';
import '../utils/initials.dart';

class CurrentUserProfile {
  const CurrentUserProfile({this.firstName = '', this.lastName = ''});

  final String firstName;
  final String lastName;

  String get displayName => [
    firstName.trim(),
    lastName.trim(),
  ].where((name) => name.isNotEmpty).join(' ');

  String get initials => getInitials(firstName, lastName);
}

/// État local en mémoire : il est perdu lorsque l’application est fermée.
class CurrentUser {
  static final profile = ValueNotifier(const CurrentUserProfile());

  static void update({required String firstName, required String lastName}) {
    profile.value = CurrentUserProfile(
      firstName: firstName.trim(),
      lastName: lastName.trim(),
    );
  }
}
