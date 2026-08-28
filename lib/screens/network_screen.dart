import 'package:flutter/material.dart';
import '../widgets/avatar.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  final _invitations = <_Invitation>[
    const _Invitation(
      name: 'Lougué Fatoumata',
      subtitle: 'Étudiant(e) · Licence informatique',
      initials: 'LF',
      color: 0xFF5B2DA3,
    ),
    const _Invitation(
      name: 'Catherine Bonkoungou',
      subtitle: 'Étudiant(e) au lycée privé technique Abbé Pierre',
      initials: 'CB',
      color: 0xFF78909C,
    ),
    const _Invitation(
      name: 'Moussa Traoré',
      subtitle: 'Développeur web · Bamako',
      initials: 'MT',
      color: 0xFF0A66C2,
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
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
            Icon(Icons.search, color: Color(0xFF1D2226)),
            SizedBox(width: 10),
            Text('Rechercher', style: TextStyle(color: Color(0xFF536471))),
          ],
        ),
      ),
    ),
    body: ListView(
      children: [
        const _NetworkTabs(),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
          child: Text(
            'Invitations (${_invitations.length})',
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
          ),
        ),
        ..._invitations.map(
          (invitation) => _InvitationTile(
            invitation: invitation,
            onDismiss: () => setState(() => _invitations.remove(invitation)),
            onAccept: () {
              setState(() => _invitations.remove(invitation));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Vous êtes maintenant en relation avec ${invitation.name}.',
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 9),
        const Divider(height: 1, thickness: 8, color: Color(0xFFF3F2EF)),
        const ListTile(
          leading: Icon(Icons.manage_accounts_outlined),
          title: Text(
            'Gérer mon réseau',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          trailing: Icon(Icons.chevron_right),
        ),
        const Divider(height: 1),
        const ListTile(
          leading: Icon(
            Icons.workspace_premium_outlined,
            color: Color(0xFFC58B19),
          ),
          title: Text('Personnes qui ont consulté votre profil'),
          subtitle: Text('Premium'),
          trailing: Icon(Icons.chevron_right),
        ),
      ],
    ),
  );
}

class _NetworkTabs extends StatelessWidget {
  const _NetworkTabs();
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 61,
    child: Row(
      children: const [
        Expanded(
          child: Center(
            child: Text(
              'Développer',
              style: TextStyle(
                color: Color(0xFF057642),
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Reprendre contact',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    ),
  );
}

class _InvitationTile extends StatelessWidget {
  const _InvitationTile({
    required this.invitation,
    required this.onDismiss,
    required this.onAccept,
  });
  final _Invitation invitation;
  final VoidCallback onDismiss, onAccept;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(18, 12, 12, 12),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InitialAvatar(
          initials: invitation.initials,
          colorValue: invitation.color,
          radius: 33,
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                invitation.name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                invitation.subtitle,
                style: const TextStyle(color: Color(0xFF666666), fontSize: 15),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: onDismiss,
                    child: const Text('Ignorer'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: onAccept,
                    child: const Text('Accepter'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Invitation {
  const _Invitation({
    required this.name,
    required this.subtitle,
    required this.initials,
    required this.color,
  });
  final String name, subtitle, initials;
  final int color;
}
