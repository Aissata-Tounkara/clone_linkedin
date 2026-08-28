import 'package:flutter/material.dart';
import '../models/search_item.dart';
import 'avatar.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({super.key, required this.item});
  final SearchItem item;
  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 1),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      leading: InitialAvatar(
        initials: item.initials,
        colorValue: item.colorValue,
      ),
      title: Text(
        item.title,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(item.subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    ),
  );
}
