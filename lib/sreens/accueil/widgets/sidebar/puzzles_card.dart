import 'package:flutter/material.dart';

/// Carte "Les casse-têtes du jour" (colonne droite)
class PuzzlesCard extends StatelessWidget {
  const PuzzlesCard({super.key});

  static const List<Map<String, String>> _puzzles = [
    {'title': 'Zip No. 522', 'subtitle': '4 relations ont joué'},
    {'title': 'Patches No. 157', 'subtitle': '2 relations ont joué'},
    {'title': 'Mini Sudoku No. 375', 'subtitle': '1 relation a joué'},
    {'title': 'Tango No. 683', 'subtitle': '2 relations ont joué'},
  ];

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Les casse-têtes du jour',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          for (int i = 0; i < _puzzles.length; i++)
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.primaries[i % Colors.primaries.length],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              title: Text(_puzzles[i]['title']!,
                  style: const TextStyle(fontSize: 13)),
              subtitle: Text(_puzzles[i]['subtitle']!,
                  style: const TextStyle(fontSize: 11)),
              trailing: const Icon(Icons.chevron_right, size: 18),
            ),
          const SizedBox(height: 4),
          const Text('Voir plus ⌄',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
        ],
      ),
    );
  }
}
