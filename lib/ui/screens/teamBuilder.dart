import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piction_ia_ry/services/api_service.dart';
import 'package:piction_ia_ry/services/data.dart' as data;

class TeamBuilder extends StatefulWidget {
  final String gameSessionId; // Paramètre pour l'ID de la session de jeu

  const TeamBuilder({super.key, required this.gameSessionId});

  @override
  State<TeamBuilder> createState() => _TeamBuilderState();
}

class _TeamBuilderState extends State<TeamBuilder> {
  List<int> teamBlue = [];
  List<int> teamOrange = [];
  bool isGameReady = false;

  @override
  void initState() {
    super.initState();
    _fetchTeamData(); // Fetch initial team data when the page loads
    print('Game Session ID: ${widget.gameSessionId}');
    // print les deux équipes
    print('Équipe Bleue: $teamBlue');
    print('Équipe Orange: $teamOrange');
  }

  Future<void> _fetchTeamData() async {
    try {
      final teamData = await ApiService().joinGameSession(widget.gameSessionId, '');
      setState(() {
        teamBlue = teamData['blue_team'] ?? []; // Assigner une liste vide si null
        teamOrange = teamData['red_team'] ?? []; // Assigner une liste vide si null
        _checkGameReady();
      });
    } catch (e) {
      print('Error fetching team data: $e');
    }
  }

  Future<void> _joinTeam(String teamColor) async {
    if ((teamColor == 'blue' && teamBlue.length < 2) ||
        (teamColor == 'red' && teamOrange.length < 2)) {
      try {
        final teamData = await ApiService().joinGameSession(widget.gameSessionId, teamColor);
        setState(() {
          teamBlue = teamData['blue_team'] ?? []; // Assigner une liste vide si null
          teamOrange = teamData['red_team'] ?? []; // Assigner une liste vide si null
          _checkGameReady();
        });
      } catch (e) {
        print('Error joining team: $e');
      }
    } else {
      print('Team is full');
    }
  }

  void _checkGameReady() {
    setState(() {
      isGameReady = teamBlue.length == 2 && teamOrange.length == 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Builder'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'ID de la Session de Jeu: ${widget.gameSessionId}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Équipe Bleue',
                        style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () => _joinTeam('blue'),
                        child: Text('Rejoindre'),
                      ),
                    ],
                  ),
                  for (var playerId in teamBlue)
                    ListTile(
                      title: Text('Player $playerId'),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Équipe Orange',
                        style: TextStyle(fontSize: 24, color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () => _joinTeam('red'),
                        child: Text('Rejoindre'),
                      ),
                    ],
                  ),
                  for (var playerId in teamOrange)
                    ListTile(
                      title: Text('Player $playerId'),
                    ),
                ],
              ),
            ),
            if (isGameReady)
              ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text('Lancer la Partie'),
              ),
          ],
        ),
      ),
    );
  }
}
