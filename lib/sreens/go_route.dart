import 'package:go_router/go_router.dart';
import 'package:linkedin_clone/sreens/accueil/home_screen.dart';
import 'package:linkedin_clone/sreens/entreprise/homme1_screen.dart';

GoRouter appGorouter=GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/",builder:(context, state) {
      return HomeScreen();
    },),
    GoRoute(path: "/entreprise",builder: (context, state) {
      return BusinessMenuPanel();
    },)
  ]
  );