import 'package:flutter/material.dart';

/// Carte "Ajouter à votre fil d'actualité" (colonne droite)
class SuggestionsCard extends StatelessWidget {
  const SuggestionsCard({super.key});

  static const List<Map<String, String>> _suggestions = [
    {
      'name': 'BENIN EXCELLENCE',
      'subtitle': 'Entreprise • Organisations à but non lu...'
    },
    {
      'name': 'GDIZ - Glo-Djigbé Industrial ...',
      'subtitle': 'Entreprise • Commerce et développeme...'
    },
    {'name': 'Agence des Systèmes ...', 'subtitle': 'Entreprise'},
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
          const Text("Ajouter à votre fil d'actualité",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          for (final s in _suggestions)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s['name']!,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500)),
                        Text(s['subtitle']!,
                            style:
                                const TextStyle(fontSize: 11, color: Colors.black54)),
                        const SizedBox(height: 4),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 28),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('+ Suivre', style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
