 import 'package:flutter/material.dart';
//import 'package:linkedin_clone/sreens/entreprise/homme1_screen.dart';
 import 'package:linkedin_clone/sreens/go_route.dart';
//import 'sreens/accueil/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LinkedIn Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF4F2EE),
      ),
      routerConfig: appGorouter,
    );
    
  }
}