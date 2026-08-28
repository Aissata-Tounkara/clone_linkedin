import 'package:flutter/material.dart';

//import 'menu_item.dart';
//import 'menu_item.dart';

/// Colonne gauche complète : carte profil + vues du profil + menu
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          // Bannière + avatar
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 55,
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(8)),
                ),
              ),
              const Positioned(
                left: 12,
                top: 25,
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.lightBlue,
                  child: Text("TS",style: TextStyle(color: Colors.black,fontSize: 20),)
              )
              )
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  ' TAWEMA Salomon',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Étudiant en mathématiques, Embassadeur 10000Codeur|developeur flutter | En for...',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Cotonou, Littoral',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.school, size: 14),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        "Université d'Abomey-Calavi",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          const Divider(height: 1),
          // Bandeau Premium
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Optimisez votre réseau avec Premium',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.bolt, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    const Expanded(
                      child: Text(
                        'Essayez pendant 1 mois pour 0 F CFA',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
        const SizedBox(height: 8),
       Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Vues du profil', style: TextStyle(fontSize: 12)),
              Text('27',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Voir toutes les statistiques',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
        const SizedBox(height: 8),
        Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      child: const Column(
        spacing: 18,
        children: [
          Row(children: [Icon(Icons.bookmark_border,size: 18),Text("Éléments enregistrés",style: TextStyle(fontSize: 12))]),
          Row(children: [Icon(Icons.group_outlined,size: 18),Text("Groupe",style: TextStyle(fontSize: 12))]),
          Row(children: [Icon(Icons.newspaper_outlined,size: 18),Text("Newsletters",style: TextStyle(fontSize: 12))]),
          Row(children: [Icon(Icons.event_note_outlined,size: 18),Text("Événements",style: TextStyle(fontSize: 12))],)
        ],
      ),
    ),
      ],
    );
  }
}