import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confetti/confetti.dart';
import 'package:piction_ia_ry/ui/screens/scoreBoardDetails.dart';

class ScoreBoard extends StatefulWidget {
  final bool isBlueTeamWinner;

  const ScoreBoard({super.key, required this.isBlueTeamWinner});

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController();
    _confettiController.play();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Victoire des ',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black, // "Victoire de" reste en noir
              ),
            ),
            Text(
              widget.isBlueTeamWinner ? 'Bleu' : 'Orange',
              style: TextStyle(
                fontSize: 28,
                color: widget.isBlueTeamWinner ? Colors.blue : Colors.orange, // "Bleu" ou "Orange" change de couleur
              ),
            ),
            const SizedBox(width: 10), // Espacement entre le texte et le SVG
            SvgPicture.string(
              '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 32 32"><path d="M26 7h-2V6a2.002 2.002 0 0 0-2-2H10a2.002 2.002 0 0 0-2 2v1H6a2.002 2.002 0 0 0-2 2v3a4.005 4.005 0 0 0 4 4h.322A8.169 8.169 0 0 0 15 21.934V26h-5v2h12v-2h-5v-4.069A7.966 7.966 0 0 0 23.74 16H24a4.005 4.005 0 0 0 4-4V9a2.002 2.002 0 0 0-2-2zM8 14a2.002 2.002 0 0 1-2-2V9h2zm18-2a2.002 2.002 0 0 1-2 2V9h2z" fill="#FFD700"></path></svg>',
              width: 32,
              height: 32,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text(
                "Équipe Bleu",
                style: TextStyle(color: Colors.blue), // Texte en bleu pour l'équipe bleu
              ),
            ),
            Tab(
              child: Text(
                "Équipe Orange",
                style: TextStyle(color: Colors.orange), // Texte en orange pour l'équipe orange
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: true,
              colors: const [
                Colors.blue,
                Colors.orange,
                Colors.purple,
                Colors.green,
              ],
            ),
          ),
          TabBarView(
            controller: _tabController,
            children: [
              _buildTeamSummaryView(true), // Vue pour l'équipe Bleu
              _buildTeamSummaryView(false), // Vue pour l'équipe Orange
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSummaryView(bool isWinner) {
    String teamName = isWinner ? 'Bleu' : 'Orange';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 6, // Par exemple, trois éléments dans la liste
              itemBuilder: (context, index) {
                return _buildSummaryItem();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image à gauche
            Image.asset(
              'assets/images/imageExample.jpg', // Remplace avec le nom de ton image
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 10),
            // Phrase et points
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Une poule sur un mur', // Phrase
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: const [
                      Text(
                        '+25',
                        style: TextStyle(color: Colors.green, fontSize: 16), // Points positifs en vert
                      ),
                      SizedBox(width: 10),
                      Text(
                        '-8',
                        style: TextStyle(color: Colors.red, fontSize: 16), // Points négatifs en rouge
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  // Étiquettes
                  Wrap(
                    spacing: 8.0,
                    children: const [
                      Chip(
                        label: Text('Poulet'),
                        backgroundColor: Colors.redAccent,
                        labelStyle: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      Chip(
                        label: Text('Volaille'),
                        backgroundColor: Colors.redAccent,
                        labelStyle: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      Chip(
                        label: Text('Oiseau'),
                        backgroundColor: Colors.redAccent,
                        labelStyle: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Icône œil
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScoreBoardDetails()), // Redirection vers ScoreBoardDetails
                );              },
              icon: SvgPicture.string(
                '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 32 32"><circle cx="16" cy="16" r="4" fill="#666666"></circle><path d="M30.94 15.66A16.69 16.69 0 0 0 16 5A16.69 16.69 0 0 0 1.06 15.66a1 1 0 0 0 0 .68A16.69 16.69 0 0 0 16 27a16.69 16.69 0 0 0 14.94-10.66a1 1 0 0 0 0-.68zM16 22.5a6.5 6.5 0 1 1 6.5-6.5a6.51 6.51 0 0 1-6.5 6.5z" fill="#666666"></path></svg>',
                width: 32,
                height: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
