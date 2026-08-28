import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/repository.dart';
import '../pages/conversation_page.dart';
import '../pages/auth_page.dart';
import '../pages/create_post_page.dart';
import '../pages/home_page.dart';
import '../pages/jobs_page.dart';
import '../pages/messaging_page.dart';
import '../pages/network_page.dart';
import '../pages/notifications_page.dart';
import '../pages/post_detail_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/job_detail_screen.dart';
import '../screens/new_message_screen.dart';
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
          GoRoute(path: '/', builder: (context, state) => const HomePage()),
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: '/network',
            builder: (context, state) => const NetworkPage(),
          ),
          GoRoute(path: '/jobs', builder: (context, state) => const JobsPage()),
          GoRoute(
            path: '/notifications',
            builder: (context, state) => const NotificationsPage(),
          ),
          GoRoute(
            path: '/messaging',
            builder: (context, state) => const MessagingPage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
      GoRoute(
        path: '/conversation/:id',
        builder: (context, state) {
          final raw = state.pathParameters['id'] ?? '';
          final conversations = Repository.instance.conversations;
          final byIndex = int.tryParse(raw);
          final conversation =
              Repository.instance.conversationById(raw) ??
              (byIndex != null && byIndex >= 0 && byIndex < conversations.length
                  ? conversations[byIndex]
                  : null);
          if (conversation == null) return _notFound(context, state);
          return ConversationPage(conversation: conversation);
        },
      ),
      GoRoute(
        path: '/post/:id',
        builder: (context, state) {
          final post = Repository.instance.postById(state.pathParameters['id'] ?? '');
          if (post == null) return _notFound(context, state);
          return PostDetailPage(post: post);
        },
      ),
      GoRoute(
        path: '/u/:id',
        builder: (context, state) =>
            ProfilePage(userId: state.pathParameters['id']),
      ),
      GoRoute(
        path: '/create-post',
        builder: (context, state) => const CreatePostPage(),
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/job/:id',
        builder: (context, state) {
          final job = Repository.instance.jobById(
            state.pathParameters['id'] ?? '',
          );
          if (job == null) return _notFound(context, state);
          return JobDetailScreen(job: job);
        },
      ),
      GoRoute(
        path: '/messaging/new',
        builder: (context, state) => const NewMessageScreen(),
      ),
    ],
  );
}
