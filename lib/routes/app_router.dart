import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/auth_page.dart';
import '../pages/profile_page.dart';
import '../widgets/linkedin_bottom_navigation_bar.dart';

class AppRouter {
  static Widget _notFound(BuildContext context, GoRouterState state) =>
      Scaffold(
        appBar: AppBar(title: const Text('Page introuvable')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.search_off_outlined, size: 48),
                const SizedBox(height: 12),
                const Text('Cette page n’existe pas.'),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Retour à l’accueil'),
                ),
              ],
            ),
          ),
        ),
      );

  static final router = GoRouter(
    initialLocation: '/auth',
    errorBuilder: _notFound,
    routes: [
      GoRoute(path: '/auth', builder: (context, state) => const AuthPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),
      ShellRoute(
        builder: (context, state, child) => Scaffold(
          body: child,
          bottomNavigationBar: LinkedInBottomNavigationBar(
            location: state.uri.path,
          ),
        ),
        routes: [
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
  );
}
