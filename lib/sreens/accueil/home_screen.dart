import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/feed/create_post_card.dart';
//import '../widgets/app_bar/linkedin_app_bar.dart';
import 'widgets/feed/feed_post_card.dart';
import 'widgets/profile/profile_card.dart';
import 'widgets/sidebar/puzzles_card.dart';
import 'widgets/sidebar/suggestions_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      title:Row(
        children: [
          const SizedBox(width: 100),
          // Barre de recherche
          Expanded(
            child: Container(
              height: 36,
              constraints: const BoxConstraints(maxWidth: 280),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF3F8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Rechercher',
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                  prefixIcon: Icon(Icons.search, size: 20, color: Colors.black54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(onPressed: (){
          context.push("/");
        }, icon: Icon(Icons.home)),
        IconButton(onPressed: (){}, icon: Icon(Icons.people)),
        IconButton(onPressed: (){}, icon: Icon(Icons.work)),
        IconButton(onPressed: (){}, icon: Icon(Icons.message)),
        IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
        ElevatedButton.icon(onPressed: (){
          context.push("/entreprise");
        }, label: Icon(Icons.arrow_drop_down),icon: Icon(Icons.apps),)
    //     Icon(Icons.apps, color: Colors.black54, size: 24),
    // Row(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     Text(
    //       "Pour les entreprises",
    //       style: TextStyle(fontSize: 10, color: Colors.black54),
    //     ),
    //     Icon(Icons.arrow_drop_down, size: 14, color: Colors.black54),
    //   ],
    // ),
      ],
     
     
     ),
      body: Container(
        color: const Color(0xFFF4F2EE),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1128),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Colonne gauche - Profil
                  const SizedBox(width: 225, child: ProfileCard()),
                  const SizedBox(width: 16),
                  // Colonne centrale - Fil d'actualité
                  Expanded(
                    child: Column(
                      children: const [
                        CreatePostCard(),
                        SizedBox(height: 8),
                        FeedPostCard(),
                        SizedBox(height: 8),
                         FeedPostCard1(),
                        SizedBox(height: 8),
                        FeedPostCard2(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Colonne droite - Suggestions
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: const [
                        PuzzlesCard(),
                        SizedBox(height: 16),
                        SuggestionsCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
