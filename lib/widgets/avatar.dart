import 'package:flutter/material.dart';
import '../state/current_user.dart';

class InitialAvatar extends StatelessWidget {
  const InitialAvatar({
    super.key,
    required this.initials,
    required this.colorValue,
    this.radius = 22,
  });
  final String initials;
  final int colorValue;
  final double radius;
  @override
  Widget build(BuildContext context) => CircleAvatar(
    radius: radius,
    backgroundColor: Color(colorValue),
    child: Text(
      initials,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: radius * .65,
      ),
    ),
  );
}

class CurrentUserAvatar extends StatelessWidget {
  const CurrentUserAvatar({super.key, this.radius = 22});

  final double radius;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<CurrentUserProfile>(
        valueListenable: CurrentUser.profile,
        builder: (context, profile, _) => InitialAvatar(
          initials: profile.initials,
          colorValue: 0xFF0A66C2,
          radius: radius,
        ),
      );
}
