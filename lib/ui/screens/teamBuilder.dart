import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TeamBuilder extends StatefulWidget {
<<<<<<< Updated upstream

 int sessionID;

 TeamBuilder({super.key, required this.sessionID});
=======
 final String gameSessionId; // Paramètre pour l'ID de la session de jeu
>>>>>>> Stashed changes

 const TeamBuilder({super.key, required this.gameSessionId});

 @override
 State<TeamBuilder> createState() => _TeamBuilderState();
}
<<<<<<< Updated upstream

class _TeamBuilderState extends State<TeamBuilder> {
  @override
  Widget build(BuildContext context) {
   int sessionID = widget.sessionID;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Queue', style: GoogleFonts.cabinSketch(fontSize: 28)),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                'Queue',
                style: GoogleFonts.cabinSketch(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              // Team 1 List
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Équipe Bleu',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _buildTeamList(['Joueur 1', 'Joueur 2']),
                  ],
                ),
              ),
              // Team 2 List
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Équipe Orange',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _buildTeamList(['Joueur 3', 'Joueur 4']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamList(List<String> players) {
    return Column(
      children: players
          .map((player) => Card(
                child: ListTile(
                  title: Text(player),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        players.remove(player);
                      });
                    },
                  ),
                ),
              ))
          .toList(),
    );
  }
=======

class _TeamBuilderState extends State<TeamBuilder> {
 String? playerId;
 List<String> teamBlue = [];
 List<String> teamOrange = [];
 bool isGameReady = false;

 final String apiUrl = 'https://pictioniary.wevox.cloud/api';
 final String jwtToken = 'your_jwt_token'; // Remplacez par votre JWT

 @override
 void initState() {
  super.initState();
  _fetchPlayerInfo();
 }

 Future<void> _fetchPlayerInfo() async {
  final response = await http.get(Uri.parse('$apiUrl/me'), headers: {
   'Authorization': 'Bearer $jwtToken'
  });

  if (response.statusCode == 200) {
   final data = json.decode(response.body);
   setState(() {
    playerId = data['id'];
   });
  }
 }

 Future<void> _joinTeam(String teamColor) async {
  if ((teamColor == 'blue' && teamBlue.length < 2) ||
      (teamColor == 'orange' && teamOrange.length < 2)) {
   final response = await http.post(
    Uri.parse('$apiUrl/game_sessions/${widget.gameSessionId}/join'),
    headers: {
     'Authorization': 'Bearer $jwtToken',
     'Content-Type': 'application/json'
    },
    body: json.encode({'color': teamColor}),
   );

   if (response.statusCode == 200) {
    final data = json.decode(response.body);
    setState(() {
     if (teamColor == 'blue') {
      teamBlue.add(data['player']['name']);
     } else {
      teamOrange.add(data['player']['name']);
     }
     _checkGameReady();
    });
   }
  }
 }

 void _checkGameReady() {
  setState(() {
   isGameReady = teamBlue.length == 2 && teamOrange.length == 2;
  });
 }

 Future<void> _startGame() async {
  final response = await http.post(
   Uri.parse('$apiUrl/game_sessions/${widget.gameSessionId}/start'),
   headers: {
    'Authorization': 'Bearer $jwtToken'
   },
  );

  if (response.statusCode == 200) {
   // Traitez le début de la partie ici (par ex., redirigez vers la page de jeu)
  }
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
      // Affichage de l'ID de la session de jeu
      Text(
       'ID de la Session de Jeu: ${widget.gameSessionId}',
       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 20),

      // Section pour l'équipe Bleue
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
         for (var player in teamBlue)
          ListTile(
           title: Text(player),
          ),
        ],
       ),
      ),
      // Section pour l'équipe Orange
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
            onPressed: () => _joinTeam('orange'),
            child: Text('Rejoindre'),
           ),
          ],
         ),
         for (var player in teamOrange)
          ListTile(
           title: Text(player),
          ),
        ],
       ),
      ),
      // Bouton pour démarrer la partie
      if (isGameReady)
       ElevatedButton(
        onPressed: _startGame,
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
>>>>>>> Stashed changes
}
