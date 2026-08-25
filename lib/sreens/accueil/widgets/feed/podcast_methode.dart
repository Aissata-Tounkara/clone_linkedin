

import 'package:flutter/material.dart';

class MethodPodcast extends StatelessWidget {
  final Color _Couleur;
  final String _AvtText;
  final String _Nom;
  final String _Message;
  final String _Descrip;
  final String _Rang;
  final int _Like;
  final int _comm;  

  const MethodPodcast({super.key, required Color Couleur, required String AvtText, required String Nom, required String Message, required String Descrip, required String Rang, required int Like, required int comm }) : _Couleur = Couleur, _AvtText = AvtText, _Nom = Nom, _Message = Message, _Descrip = Descrip, _Rang = Rang, _Like = Like, _comm = comm;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
               CircleAvatar(
                  radius: 22,
                  backgroundColor: _Couleur,
                  child: Text(_AvtText,style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(_Nom,
                        style:TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(_Descrip,
                        //'Flutter Developer | DevSecOps Enqineer | Cloud & Cybersecurity ...',
                        style: TextStyle(fontSize: 11, color: Colors.black54),
                      ),
                      Text(_Rang,
                          style: TextStyle(fontSize: 11, color: Colors.black54)),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz, color: Colors.black54),
                const SizedBox(width: 4),
                const Icon(Icons.close, size: 18, color: Colors.black54),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: RichText(
              text:  TextSpan(
                style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4),
                children: [
                  TextSpan(
                     text:_Message, //'Je suis heureux de partager une nouvelle étape dans mon parcours '
                    //     'en flutter \n'
                    //     'Hackviser, une plateforme d\'apprentissage pratique dédiée à la '
                    //     'cybersécurité et aux challenges techniques. 🛰️📘\n\n'
                    //     'Cette formation m\'a permis de consolider mes connaissances à '
                    //     'travers des exercices pratiques et des CTF (Capture The Flag), '
                    //     'en travaillant notamment sur :\n'
                    //     '• Réseaux & IP Subnetting — FLSM, VLSM, calcul des sous-réseaux et... ',
                  ),
                ],
            ),
          )),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.thumb_up,color: Colors.blue),
              const SizedBox(height: 8),
              Text("$_Like"),
              Spacer(),
              Text("$_comm commentaires")
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black)
            ),
            child: Column(
              mainAxisAlignment: .spaceBetween,
              children: [
                Row(children: [Icon(Icons.thumb_up),const SizedBox(height: 8),Text("J'aime")],),
                Row(children: [Icon(Icons.comment),const SizedBox(height: 8),Text("Commenter")],),
                Row(children: [Icon(Icons.share),const SizedBox(height: 8),Text("Partager")],),
              ],
            ),
          )
        ],
      ),
    );
  }
}
  
