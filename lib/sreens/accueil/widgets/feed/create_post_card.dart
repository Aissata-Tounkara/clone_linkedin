import 'package:flutter/material.dart';

/// Carte "Commencer un post" en haut du fil d'actualité
class CreatePostCard extends StatelessWidget {
  const CreatePostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.lightBlue,
                  child: Text("TS",style: TextStyle(color: Colors.white,fontSize: 20),)
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Commencer un post',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:  [
              IconButton(onPressed: (){}, icon: Icon(Icons.event)),
              IconButton(onPressed: (){}, icon: Icon(Icons.article))
              // _PostActionButton(
              //     icon: Icons.event, label: 'Événement', color: Colors.orange),
              // _PostActionButton(
              //     icon: Icons.article,
              //     label: 'Rédiger un article',
              //     color: Colors.redAccent),
            ],
          ),
        ],
      ),
    );
  }
}

/// Bouton privé, utilisé uniquement par [CreatePostCard]
// class _PostActionButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;

//   const _PostActionButton({
//     required this.icon,
//     required this.label,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextButton.icon(
//       onPressed: () {},
//       icon: Icon(icon, color: color, size: 18),
//       label:
//           Text(label, style: const TextStyle(color: Colors.black54, fontSize: 13)),
//     );
//   }
// }


