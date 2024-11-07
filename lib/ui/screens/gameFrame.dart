import 'dart:async';
import 'package:flutter/material.dart';

class gameFrame extends StatefulWidget {
  const gameFrame({super.key});

  @override
  State<gameFrame> createState() => _gameFrameState();
}

class _gameFrameState extends State<gameFrame> {
  int _remainingTime = 200; // 300 secondes (5 minutes)
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Annule le timer lorsqu'on quitte la page
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel(); // Arrête le timer à 0
      }
    });
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Retire le focus de l'input
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true, // Empêche le clavier de cacher l'input
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.black
                      .withOpacity(0.7), // Fond noir semi-transparent
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  formatTime(_remainingTime),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20), // Espacement de 20px
              // Card avec challenge et chips
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // même radius pour la Card
                ),
                color: Color(0xFFe77708), // Fond orange de la Card
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.draw,
                          color: Colors.white), // Icône blanche
                      title: Text(
                        'Votre challenge : Dessiner un chat',
                        style: TextStyle(color: Colors.white), // Texte blanc
                      ),
                    ),
                    Wrap(
                      spacing: 8.0, // Espace entre les puces
                      runSpacing: 4.0, // Espace entre les lignes
                      children: <Widget>[
                        Chip(
                          avatar: CircleAvatar(
                              backgroundColor: Colors.red.shade900),
                          label: const Text(
                            'Hamilton',
                            style:
                                TextStyle(color: Colors.white), // Texte blanc
                          ),
                          backgroundColor:
                              Color(0xFFe77708), // Fond orange des puces
                          side: BorderSide(
                              color: Colors.white), // Bordure blanche
                        ),
                        Chip(
                          avatar: CircleAvatar(
                              backgroundColor: Colors.red.shade900),
                          label: const Text(
                            'Lafayette',
                            style:
                                TextStyle(color: Colors.white), // Texte blanc
                          ),
                          backgroundColor:
                              Color(0xFFe77708), // Fond orange des puces
                          side: BorderSide(
                              color: Colors.white), // Bordure blanche
                        ),
                        Chip(
                          avatar: CircleAvatar(
                              backgroundColor: Colors.red.shade900),
                          label: const Text(
                            'Mulligan',
                            style:
                                TextStyle(color: Colors.white), // Texte blanc
                          ),
                          backgroundColor:
                              Color(0xFFe77708), // Fond orange des puces
                          side: BorderSide(
                              color: Colors.white), // Bordure blanche
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Espacement de 20px

              // Image en carré
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // même radius que la Card
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        'https://p.potaufeu.asahi.com/1831-p/picture/27695628/89644a996fdd0cfc9e06398c64320fbe.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Espacement de 20px

              // Boutons régénérer et envoyer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Action pour régénérer l'image
                      },
                      icon: const Icon(Icons.refresh), // Icône pour régénérer
                      label: const Text(
                        'Régénérer l\'image',
                        overflow: TextOverflow
                            .visible, // Texte à la ligne si nécessaire
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Couleur du bouton
                        foregroundColor: Colors.white, // Couleur du texte
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Espace entre les boutons
                  Flexible(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Action pour envoyer au devineur
                      },
                      icon: const Icon(Icons.send),
                      label: const Text(
                        'Envoyer au devineur',
                        overflow: TextOverflow
                            .visible, // Texte à la ligne si nécessaire
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFe77708), // Couleur du bouton
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Espace maximal avant l'input

              // Input pour envoyer un message
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Envoyer un message',
                          labelStyle: TextStyle(
                              color: Color(0xFFe77708)), // Texte orange
                          //border none
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white, // Fond blanc pour l'input
                          suffixIcon: IconButton(
                            onPressed: () {
                              // Action pour envoyer le message
                            },
                            icon: const Icon(Icons.send),
                            color: Color(0xFFe77708), // Couleur du bouton
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
