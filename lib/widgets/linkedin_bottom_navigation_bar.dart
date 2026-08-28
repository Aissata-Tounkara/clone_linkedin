import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repository.dart';
import '../theme/app_tokens.dart';
import 'li_widgets.dart';

class LinkedInBottomNavigationBar extends StatelessWidget {
  const LinkedInBottomNavigationBar({super.key, required this.location});
  final String location;

  static const _paths = ['/', '/network', '/create-post', '/notifications', '/jobs'];

  int get _index {
    final i = _paths.indexWhere(
      (p) => p == '/' ? location == '/' : location.startsWith(p),
    );
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    final repo = Repository.instance;
    return AnimatedBuilder(
      animation: repo,
      builder: (context, _) {
        return Container(
          decoration: const BoxDecoration(
            color: LiColors.surface,
            border: Border(top: BorderSide(color: LiColors.hairline)),
          ),
          child: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (i) {
              if (i == 2) {
                context.push('/create-post');
              } else {
                context.go(_paths[i]);
              }
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Accueil',
              ),
              NavigationDestination(
                icon: LiBadge(
                  count: repo.pendingInvitations,
                  child: const Icon(Icons.people_outline),
                ),
                selectedIcon: const Icon(Icons.people),
                label: 'Mon réseau',
              ),
              const NavigationDestination(
                icon: Icon(Icons.add_box_outlined),
                selectedIcon: Icon(Icons.add_box),
                label: 'Publier',
              ),
              NavigationDestination(
                icon: LiBadge(
                  count: repo.unreadNotifications,
                  child: const Icon(Icons.notifications_none),
                ),
                selectedIcon: const Icon(Icons.notifications),
                label: 'Notifications',
              ),
              const NavigationDestination(
                icon: Icon(Icons.work_outline),
                selectedIcon: Icon(Icons.work),
                label: 'Emplois',
              ),
            ],
          ),
        );
      },
    );
  }
}
