import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piction_ia_ry/services/api_service.dart';
import 'package:piction_ia_ry/ui/screens/teamBuilder.dart';
import 'package:piction_ia_ry/services/data.dart' as data;



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
    try {
      final sessionId = await apiService.createGameSession();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Session Created'),
            content: Text('Game Session ID: $sessionId'),
            actions: [
              TextButton(
                onPressed: () async {
                  await apiService.joinGameSession(sessionId, "blue");
                  print('Session joined');
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      ).then((value) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TeamBuilder(gameSessionId: sessionId),
        ));
      });
    } catch (error) {
      print('Error creating game session: $error');
    }
  }

  Future<void> joinGameSession() async {
    try {
   //   await apiService.joinGameSession(sessionIdController.text, selectedColor);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TeamBuilder(gameSessionId: sessionIdController.text),
      ));
    } catch (error) {
      print('Error joining game session: $error');
    }
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
                        'Bonjour ' + data.username + '!',
                        style: TextStyle(
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
                        children: [
                          Icon(Icons.add),
                          Text('Créer une partie'),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        backgroundColor: Color(0xFFe77708),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Rejoindre une partie via ID'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: sessionIdController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
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
                                  child: Text('Annuler'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    joinGameSession();
                                  },
                                  child: Text('Rejoindre'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.qr_code),
                          Text('Rejoindre une partie via l\'ID'),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        backgroundColor: Color(0xFFe77708),
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
