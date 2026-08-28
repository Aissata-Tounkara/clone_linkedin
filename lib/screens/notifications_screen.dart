import 'package:flutter/material.dart';
import '../data/local_data.dart';
import '../widgets/notification_tile.dart';
import '../widgets/empty_state.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'Tout';

  bool _matchesFilter(String text) => switch (_selectedFilter) {
    'Emplois' => text.contains('offre') || text.contains('profil'),
    'Mes posts' => text.contains('publication'),
    'Mentions' => text.contains('commenté'),
    _ => true,
  };

  @override
  Widget build(BuildContext context) {
    final notifications = LocalData.notifications
        .where((item) => _matchesFilter(item.text.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 12,
        title: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFEDF3F8),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Row(
            children: [
              Icon(Icons.search),
              SizedBox(width: 10),
              Text('Rechercher', style: TextStyle(color: Color(0xFF536471))),
            ],
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Tout marquer comme lu',
            onPressed: () => setState(() {
              for (final item in LocalData.notifications) {
                item.read = true;
              }
            }),
            icon: const Icon(Icons.done_all),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 68,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              children: ['Tout', 'Emplois', 'Mes posts', 'Mentions']
                  .map(
                    (filter) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: _selectedFilter == filter,
                        selectedColor: const Color(0xFF057642),
                        labelStyle: TextStyle(
                          color: _selectedFilter == filter
                              ? Colors.white
                              : const Color(0xFF4A4A4A),
                          fontWeight: FontWeight.w600,
                        ),
                        onSelected: (_) =>
                            setState(() => _selectedFilter = filter),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: notifications.isEmpty
                ? const EmptyState(
                    icon: Icons.notifications_off_outlined,
                    title: 'Aucune notification',
                    message: 'Vos nouvelles interactions apparaîtront ici.',
                  )
                : ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (_, index) {
                      final notification = notifications[index];
                      return NotificationTile(
                        notification: notification,
                        onTap: () => setState(() => notification.read = true),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
