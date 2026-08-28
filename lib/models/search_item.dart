enum SearchCategory { people, companies, jobs, posts }

class SearchItem {
  const SearchItem({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.initials,
    required this.colorValue,
  });
  final SearchCategory category;
  final String title, subtitle, initials;
  final int colorValue;
}
