import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piction_ia_ry/services/data.dart' as data;


class ChallengeBuilder extends StatefulWidget {
  final int gameSessionId;

  const ChallengeBuilder({Key? key, required this.gameSessionId}) : super(key: key);

  @override
  _ChallengeBuilderState createState() => _ChallengeBuilderState();
}

class _ChallengeBuilderState extends State<ChallengeBuilder> {
  final TextEditingController firstWordController = TextEditingController();
  final TextEditingController secondWordController = TextEditingController();
  final TextEditingController thirdWordController = TextEditingController();
  final TextEditingController fourthWordController = TextEditingController();
  final TextEditingController fifthWordController = TextEditingController();
  final TextEditingController forbiddenWordsController = TextEditingController();

  int challengesSubmitted = 0;
  String status = "lobby";

  Future<void> fetchGameSessionStatus() async {
    final String token = data.token;
    final response = await http.get(
      Uri.parse('https://pictioniary.wevox.cloud/api/game_sessions/${widget.gameSessionId}/status'),
      headers: {'Authorization': 'Bearer  $token'},
    );

    if (response.statusCode == 200) {
      setState(() {
        status = json.decode(response.body)['status'];
      });
    }
  }

  Future<void> submitChallenge() async {
    final List<String> forbiddenWords = forbiddenWordsController.text.split(',').map((word) => word.trim()).toList();

    final challengeData = {
      "first_word": firstWordController.text,
      "second_word": secondWordController.text,
      "third_word": thirdWordController.text,
      "fourth_word": fourthWordController.text,
      "fifth_word": fifthWordController.text,
      "forbidden_words": forbiddenWords,
    };

    final response = await http.post(
      Uri.parse('https://pictioniary.wevox.cloud/api/game_sessions/${widget.gameSessionId}/challenges'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_JWT_TOKEN',
      },
      body: json.encode(challengeData),
    );

    if (response.statusCode == 200) {
      setState(() {
        challengesSubmitted++;
      });

      // Vérifie si tous les challenges ont été envoyés et change le statut si nécessaire
      if (challengesSubmitted >= 3) {
        await startDrawingPhase();
      }
    } else {
      // Gérer l'erreur si besoin
      print("Erreur lors de l'envoi du challenge : ${response.body}");
    }
  }

  Future<void> startChallengePhase() async {
    final response = await http.post(
      Uri.parse('https://pictioniary.wevox.cloud/api/game_sessions/${widget.gameSessionId}/start'),
      headers: {'Authorization': 'Bearer YOUR_JWT_TOKEN'},
    );

    if (response.statusCode == 200) {
      setState(() {
        status = "challenge";
      });
    }
  }

  Future<void> startDrawingPhase() async {
    await fetchGameSessionStatus();
    if (status == "challenge") {
      // Passe la phase en "drawing" après que tous les challenges soient créés
      setState(() {
        status = "drawing";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGameSessionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un Challenge'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Session de jeu ID: ${widget.gameSessionId}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            TextField(controller: firstWordController, decoration: InputDecoration(labelText: 'Premier mot')),
            TextField(controller: secondWordController, decoration: InputDecoration(labelText: 'Deuxième mot')),
            TextField(controller: thirdWordController, decoration: InputDecoration(labelText: 'Troisième mot')),
            TextField(controller: fourthWordController, decoration: InputDecoration(labelText: 'Quatrième mot')),
            TextField(controller: fifthWordController, decoration: InputDecoration(labelText: 'Cinquième mot')),
            TextField(controller: forbiddenWordsController, decoration: InputDecoration(labelText: 'Mots interdits (séparés par des virgules)')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitChallenge,
              child: Text('Soumettre le challenge'),
            ),
            if (challengesSubmitted > 0)
              Text('Challenges soumis : $challengesSubmitted / 3', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            if (status == "drawing")
              Text('Tous les challenges sont créés, phase de dessin activée !', style: TextStyle(fontSize: 16, color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
