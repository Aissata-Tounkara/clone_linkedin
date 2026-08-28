import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repository.dart';
import '../data/seed_data.dart';
import '../models/user.dart';
import '../theme/app_tokens.dart';
import '../widgets/gen_avatar.dart';
import '../widgets/li_widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final _recent = <String>['Développeur Flutter', 'Nova Labs', 'Sophie Martin'];
  String _query = '';
  String _tab = 'Tout';

  static const _tabs = ['Tout', 'Personnes', 'Publications', 'Emplois', 'Entreprises'];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: (v) => setState(() => _query = v),
          onSubmitted: (v) {
            if (v.trim().isNotEmpty && !_recent.contains(v.trim())) {
              _recent.insert(0, v.trim());
            }
          },
          decoration: InputDecoration(
            hintText: 'Rechercher',
            filled: true,
            fillColor: LiColors.searchField,
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              onPressed: () => setState(() {
                _controller.clear();
                _query = '';
              }),
              icon: const Icon(Icons.close),
            ),
        ],
      ),
      body: _query.isEmpty ? _idle() : _results(),
    );
  }

  Widget _idle() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text('Récent',
              style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        for (final r in _recent)
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(r),
            trailing: IconButton(
              icon: const Icon(Icons.close, size: 18),
              onPressed: () => setState(() => _recent.remove(r)),
            ),
            onTap: () => setState(() {
              _controller.text = r;
              _query = r;
            }),
          ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text('Essayez de rechercher',
              style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        for (final s in const [
          'Personnes que je connais',
          'Offres « Flutter »',
          'Contenu sur le design system',
        ])
          ListTile(
            leading: const Icon(Icons.search),
            title: Text(s),
            onTap: () => setState(() {
              _controller.text = s;
              _query = s;
            }),
          ),
      ],
    );
  }

  Widget _results() {
    final q = _query.toLowerCase();
    final people = Seed.users.values
        .where((u) =>
            u.name.toLowerCase().contains(q) ||
            u.headline.toLowerCase().contains(q))
        .toList();
    final posts = Repository.instance.feed
        .where((p) => p.content.toLowerCase().contains(q))
        .toList();
    final jobs = Repository.instance.jobs
        .where((j) =>
            j.title.toLowerCase().contains(q) ||
            j.company.toLowerCase().contains(q))
        .toList();

    return Column(
      children: [
        LiChipsRow(
          options: _tabs,
          selected: _tab,
          onSelected: (v) => setState(() => _tab = v),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView(
            children: [
              if (_tab == 'Tout' || _tab == 'Personnes')
                ..._section('Personnes', [
                  for (final User u in people.take(_tab == 'Tout' ? 3 : 20))
                    ListTile(
                      leading: GenAvatar(seed: u.seed, name: u.name, size: 44),
                      title: Text(u.name,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(
                        u.headline,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Se connecter'),
                      ),
                      onTap: () => context.push('/u/${u.id}'),
                    ),
                ]),
              if (_tab == 'Tout' || _tab == 'Publications')
                ..._section('Publications', [
                  for (final p in posts.take(_tab == 'Tout' ? 3 : 20))
                    ListTile(
                      leading: GenAvatar(seed: p.seed, name: p.author, size: 44),
                      title: Text(
                        p.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text('Publication de ${p.author}'),
                      onTap: () => context.push('/post/${p.id}'),
                    ),
                ]),
              if (_tab == 'Tout' || _tab == 'Emplois')
                ..._section('Emplois', [
                  for (final j in jobs.take(_tab == 'Tout' ? 3 : 20))
                    ListTile(
                      leading: GenAvatar(
                        seed: j.seed,
                        name: j.company,
                        size: 44,
                        shape: AvatarShape.roundedSquare,
                      ),
                      title: Text(j.title,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('${j.company} · ${j.location}'),
                      onTap: () => context.push('/job/${j.id}'),
                    ),
                ]),
              if (people.isEmpty && posts.isEmpty && jobs.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: Text('Aucun résultat')),
                ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _section(String title, List<Widget> children) {
    if (children.isEmpty) return [];
    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
      ...children,
      const Divider(),
    ];
  }
}
