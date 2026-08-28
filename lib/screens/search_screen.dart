import 'package:flutter/material.dart';
import '../data/local_data.dart';
import '../models/search_item.dart';
import '../widgets/search_result_card.dart';
import '../widgets/empty_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';
  SearchCategory? _category;
  String _label(SearchCategory value) => switch (value) {
    SearchCategory.people => 'Personnes',
    SearchCategory.companies => 'Entreprises',
    SearchCategory.jobs => 'Emplois',
    SearchCategory.posts => 'Publications',
  };
  @override
  Widget build(BuildContext context) {
    final lower = _query.toLowerCase();
    final results = LocalData.searchItems
        .where(
          (item) =>
              (_category == null || item.category == _category) &&
              (lower.isEmpty ||
                  '${item.title} ${item.subtitle}'.toLowerCase().contains(
                    lower,
                  )),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: TextField(
          autofocus: true,
          onChanged: (value) => setState(() => _query = value),
          decoration: const InputDecoration(
            hintText: 'Rechercher',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => _query = ''),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              children: [
                FilterChip(
                  label: const Text('Tous'),
                  selected: _category == null,
                  onSelected: (_) => setState(() => _category = null),
                ),
                ...SearchCategory.values.map(
                  (category) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: FilterChip(
                      label: Text(_label(category)),
                      selected: _category == category,
                      onSelected: (_) => setState(() => _category = category),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              _query.isEmpty
                  ? 'Découvrir sur LinkedIn'
                  : '${results.length} résultat(s)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const EmptyState(
                    icon: Icons.search_off_outlined,
                    title: 'Aucun résultat',
                    message: 'Essayez un autre mot-clé ou retirez un filtre.',
                  )
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (_, index) =>
                        SearchResultCard(item: results[index]),
                  ),
          ),
        ],
      ),
    );
  }
}
