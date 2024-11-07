import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:piction_ia_ry/services/api_service.dart';
import 'package:piction_ia_ry/ui/screens/teamBuilder.dart';


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
                  Navigator.of(context).pop();
                  await apiService.joinGameSession(sessionId, "blue");
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TeamBuilder(sessionID: int.parse(sessionId)),
                  ));
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Error creating game session: $error');
    }
  }

  // goToLobby function, which will be called when the user clicks the "Join" button,
  // and will display a dialog to enter the session ID.
  // then call the goToLobby function from the apiClass

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
                        'Bonjour pseudo !',
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
                                 // DropdownButton<String>(
                                 //   value: selectedColor,
                                 //   items: <String>['red', 'blue']
                                 //       .map((String value) {
                                 //     return DropdownMenuItem<String>(
                                 //       value: value,
                                 //       child: Text(value),
                                 //     );
                                 //   }).toList(),
                                 //   onChanged: (String? newValue) {
                                 //     setState(() {
                                 //       selectedColor = newValue!;
                                 //     });
                                 //   },
                                 // ),
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
                                    apiService.joinGameSession(
                                      sessionIdController.text,
                                      selectedColor,
                                    );
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
