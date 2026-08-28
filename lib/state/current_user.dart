import 'package:flutter/foundation.dart';
import '../utils/initials.dart';

class CurrentUserProfile {
  const CurrentUserProfile({
    this.firstName = '',
    this.lastName = '',
    this.headline = '',
    this.about = '',
    this.location = '',
  });

  final String firstName;
  final String lastName;
  final String headline;
  final String about;
  final String location;

  String get displayName => [
    firstName.trim(),
    lastName.trim(),
  ].where((name) => name.isNotEmpty).join(' ');

  String get initials => getInitials(firstName, lastName);

  CurrentUserProfile copyWith({
    String? firstName,
    String? lastName,
    String? headline,
    String? about,
    String? location,
  }) => CurrentUserProfile(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    headline: headline ?? this.headline,
    about: about ?? this.about,
    location: location ?? this.location,
  );
}

/// État local en mémoire : il est perdu lorsque l’application est fermée.
class CurrentUser {
  static final profile = ValueNotifier(const CurrentUserProfile());

  static void update({
    String? firstName,
    String? lastName,
    String? headline,
    String? about,
    String? location,
  }) {
    profile.value = profile.value.copyWith(
      firstName: firstName?.trim(),
      lastName: lastName?.trim(),
      headline: headline,
      about: about,
      location: location,
    );
  }
}
