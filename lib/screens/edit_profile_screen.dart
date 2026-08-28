import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/repository.dart';
import '../state/current_user.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _first;
  late final TextEditingController _last;
  late final TextEditingController _headline;
  late final TextEditingController _location;
  late final TextEditingController _about;

  @override
  void initState() {
    super.initState();
    final p = CurrentUser.profile.value;
    _first = TextEditingController(text: p.firstName);
    _last = TextEditingController(text: p.lastName);
    _headline = TextEditingController(text: p.headline);
    _location = TextEditingController(text: p.location);
    _about = TextEditingController(text: p.about);
  }

  @override
  void dispose() {
    for (final c in [_first, _last, _headline, _location, _about]) {
      c.dispose();
    }
    super.dispose();
  }

  void _save() {
    Repository.instance.updateProfile(
      firstName: _first.text,
      lastName: _last.text,
      headline: _headline.text,
      location: _location.text,
      about: _about.text,
    );
    context.pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil enregistré')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier le profil'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text(
              'Enregistrer',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _field('Prénom', _first),
          _field('Nom', _last),
          _field('Titre (headline)', _headline, maxLines: 2),
          _field('Localité', _location),
          _field('À propos', _about, maxLines: 5),
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController c, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: c,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
