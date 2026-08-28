import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BusinessMenuPanel extends StatelessWidget {
  const BusinessMenuPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:AppBar(
      title:Row(
        children: [
          const SizedBox(width: 100),
          // Barre de recherche
          Expanded(
            child: Container(
              height: 36,
              constraints: const BoxConstraints(maxWidth: 280),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF3F8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Rechercher',
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                  prefixIcon: Icon(Icons.search, size: 20, color: Colors.black54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(onPressed: (){
         context.push("/");
        }, icon: Icon(Icons.home)),
        IconButton(onPressed: (){}, icon: Icon(Icons.people)),
        IconButton(onPressed: (){}, icon: Icon(Icons.work)),
        IconButton(onPressed: (){}, icon: Icon(Icons.message)),
        IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
        ElevatedButton.icon(onPressed: (){
         context.push("/entreprise");
        }, label: Icon(Icons.arrow_drop_down),icon: Icon(Icons.apps),)
    //     Icon(Icons.apps, color: Colors.black54, size: 24),
    // Row(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     Text(
    //       "Pour les entreprises",
    //       style: TextStyle(fontSize: 10, color: Colors.black54),
    //     ),
    //     Icon(Icons.arrow_drop_down, size: 14, color: Colors.black54),
    //   ],
    // ),
      ],
     
     
     ),
      body: Column(
       // mainAxisAlignment: .center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 300),
        width: 700,
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Colonne gauche
            SizedBox(
              width: 260,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SidebarItem(icon: Icons.groups, label: "Groupes"),
                    const SizedBox(height: 20),
                    const _SectionTitle(title: "Talent"),
                    const SizedBox(height: 8),
                    _SidebarItem(icon: Icons.badge, label: "Recruter avec l'IA", iconColor: Colors.blue),
                    const SizedBox(height: 12),
                    _SidebarItem(icon: Icons.insights, label: "Talent Insights", iconColor: Colors.blue),
                    const SizedBox(height: 20),
                    const _SectionTitle(title: "Sales"),
                    const SizedBox(height: 8),
                    _SidebarItem(icon: Icons.people_alt, label: "Services Marketplace", iconColor: Colors.blue),
                  ],
                ),
              ),
            ),
        

            // Séparateur vertical
            Container(
              width: 1,
              color: Colors.grey.shade300,
            ),

            // Colonne droite
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LinkItem(
                      title: "Vendre avec LinkedIn",
                      subtitle: "Multipliez les opportunités commerciales",
                    ),
                    const SizedBox(height: 18),
                    _LinkItem(
                      title: "Publier une offre d'emploi gratuite",
                      subtitle: "Trouver des candidats de qualité",
                    ),
                    const SizedBox(height: 18),
                    _LinkItem(
                      title: "Faire de la publicité sur LinkedIn",
                      subtitle: "Trouver de nouveaux clients et développer votre activité professionnelle",
                    ),
                    const SizedBox(height: 18),
                    _LinkItem(
                      title: "Se lancer avec Premium",
                      subtitle: "Développer et exploiter votre réseau",
                    ),
                    const SizedBox(height: 18),
                    _LinkItem(
                      title: "Apprendre avec LinkedIn",
                      subtitle: "Cours de perfectionnement pour vos employés",
                    ),
                    const SizedBox(height: 18),
                    _LinkItem(
                      title: "Centre d'administration",
                      subtitle: "Gérer les détails de la facturation et du compte",
                    ),

                    const Spacer(),

                    // Lien du bas
                    InkWell(
                      onTap: () {
                        // TODO: navigation vers création de page
                      },
                      child: Row(
                        children: const [
                          Text(
                            "Créez une Page Entreprise",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.add, size: 16, color: Colors.black87),
                        ],
                      ),
                    ),
                  ],
                ),
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

// Widget pour un titre de section ("Talent", "Sales")
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.grey[600],
      ),
    );
  }
}

// Widget pour un item de la colonne de gauche (icône + texte)
class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const _SidebarItem({
    required this.icon,
    required this.label,
    this.iconColor = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: navigation
      },
      child: Row(
        children: [
          Icon(icon, size: 22, color: iconColor),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// Widget pour un item de la colonne de droite (titre + sous-titre)
class _LinkItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _LinkItem({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: navigation
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}