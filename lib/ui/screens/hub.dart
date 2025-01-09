import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piction_ia_ry/services/api_service.dart';
import 'package:piction_ia_ry/ui/screens/teamBuilder.dart';
import 'package:piction_ia_ry/services/data.dart' as data;

import 'queue.dart'; // Importez le widget Queue pour afficher le loader

class Hub extends StatefulWidget {
  const Hub({super.key});

  @override
  State<Hub> createState() => _HubState();
}

class _HubState extends State<Hub> {
  final TextEditingController sessionIdController = TextEditingController();
  String selectedColor = 'blue'; // Couleur par défaut

  final ApiService apiService = ApiService();

  Future<void> createGameSession() async {
    showDialog(
      context: context,
      barrierDismissible: false, // Empêche la fermeture en cliquant en dehors
      builder: (context) => const Queue(waitingText: 'Création de la partie...'),
    );

    try {
      final sessionId = await apiService.createGameSession();
      await apiService.joinGameSession(sessionId, "blue");
      print('Session created and joined successfully');
      Navigator.of(context).pop(); // Ferme le loader
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TeamBuilder(gameSessionId: sessionId),
        ),
      );
    } catch (error) {
      Navigator.of(context).pop(); // Ferme le loader
      print('Error creating or joining game session: $error');
      showErrorDialog('Erreur lors de la création de la partie. Veuillez réessayer.');
    }
  }

  Future<void> joinGameSession() async {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TeamBuilder(gameSessionId: sessionIdController.text),
        ),
      );
    } catch (error) {
      print('Error joining game session: $error');
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erreur'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'PICTION.IA.RY',
                style: TextStyle(
                  fontSize: 60,
                  fontFamily: GoogleFonts.cabinSketch().fontFamily,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://img.freepik.com/premium-vector/pencil-robot-logo_92637-150.jpg',
                      width: 150,
                    ),
                    Flexible(
                      child: Text(
                        'Bonjour ${data.username}!',
                        style: const TextStyle(
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: createGameSession,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.add),
                          Text('Créer une partie'),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        backgroundColor: const Color(0xFFe77708),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Rejoindre une partie via ID'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: sessionIdController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'ID de la session',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Annuler'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    joinGameSession();
                                  },
                                  child: const Text('Rejoindre'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.qr_code),
                          Text('Rejoindre une partie via l\'ID'),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        backgroundColor: const Color(0xFFe77708),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
