import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, this.userId});

  /// null → mon profil ; sinon profil public de la personne.
  final String? userId;

  @override
  Widget build(BuildContext context) => ProfileScreen(userId: userId);
}
