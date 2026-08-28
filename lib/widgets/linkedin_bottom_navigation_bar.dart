import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LinkedInBottomNavigationBar extends StatelessWidget {
  const LinkedInBottomNavigationBar({super.key, required this.location});
  final String location;
  static const _paths = [
    '/',
    '/network',
    '/create-post',
    '/notifications',
    '/jobs',
  ];
  int get _index {
    final index = _paths.indexWhere(
      (path) => path == '/' ? location == '/' : location.startsWith(path),
    );
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) => NavigationBar(
    selectedIndex: _index,
    labelBehavior: MediaQuery.sizeOf(context).width < 360
        ? NavigationDestinationLabelBehavior.alwaysHide
        : NavigationDestinationLabelBehavior.alwaysShow,
    onDestinationSelected: (index) {
      if (index == 2) {
        context.push('/create-post');
        return;
      }
      context.go(_paths[index]);
    },
    destinations: const [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Accueil',
      ),
      NavigationDestination(
        icon: Icon(Icons.people_outline),
        selectedIcon: Icon(Icons.people),
        label: 'Réseau',
      ),
      NavigationDestination(
        icon: Icon(Icons.add_box_outlined),
        selectedIcon: Icon(Icons.add_box),
        label: 'Publier',
      ),
      NavigationDestination(
        icon: Icon(Icons.notifications_outlined),
        selectedIcon: Icon(Icons.notifications),
        label: 'Notifications',
      ),
      NavigationDestination(
        icon: Icon(Icons.work_outline),
        selectedIcon: Icon(Icons.work),
        label: 'Emplois',
      ),
    ],
  );
}
