import 'package:flutter/material.dart';

import 'podcast_methode.dart';

/// Carte représentant un post dans le fil d'actualité
class FeedPostCard extends StatelessWidget {
  const FeedPostCard({super.key});

  @override
  Widget build(BuildContext context) {
     return MethodPodcast(Couleur:  Colors.blueGrey, AvtText:"SM", Nom: "Sogo Mireille", Message: 'Je suis heureux de partager une nouvelle étape dans mon parcours '
                        'en flutter \n'
                        'Hackviser, une plateforme d\'apprentissage pratique dédiée à la '
                        'cybersécurité et aux challenges techniques. 🛰️📘\n\n'
                        'Cette formation m\'a permis de consolider mes connaissances à '
                        'travers des exercices pratiques et des CTF (Capture The Flag), '
                        'en travaillant notamment sur :\n'
                        '• Réseaux & IP Subnetting — FLSM, VLSM, calcul des sous-réseaux et... ', Descrip:'Flutter Developer | DevSecOps Enqineer | Cloud & Cybersecurity ...', Rang: "1 sm", Like: 86, comm: 9);
  }
}



/// Carte représentant un post dans le fil d'actualité
class FeedPostCard1 extends StatelessWidget {
  const FeedPostCard1({super.key});

  @override
  Widget build(BuildContext context) {
     return MethodPodcast(Couleur:Colors.green, AvtText: "KB", Nom: 'Karim Benali', Message: "Une bonne équipe ne travaille j'amais pas seulement ensemble :Elle prend aussi le temps de célébrer les progrès de chacun", Descrip: 'Product Designer', Rang: "2 sm", Like: 16, comm: 10);
}
}
class FeedPostCard2 extends StatelessWidget {
  const FeedPostCard2 ({super.key});

  @override
  Widget build(BuildContext context) {
    return MethodPodcast(Couleur: Colors.pinkAccent, AvtText: "PS", Nom: "Pona Serge", Message: "Nous recruton "
    "un(e) dévelopeur(se)... \n"
    "Pour rejoindre une équipe dynamic", Descrip: "Développeuse ", Rang: "3 sm", Like: 2, comm: 7);
  }
}