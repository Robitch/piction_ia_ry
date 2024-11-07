import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:piction_ia_ry/ui/screens/hub.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piction_ia_ry/services/data.dart' as data;
import 'package:piction_ia_ry/services/api_service.dart';

class Identification extends StatefulWidget {
  const Identification({super.key});

  @override
  State<Identification> createState() => _IdentificationState();
}

class _IdentificationState extends State<Identification> {
  final myController = TextEditingController();
  final passwordController = TextEditingController();

  final String apiUrl = 'https://pictioniary.wevox.cloud/api';

  @override
  void dispose() {
    myController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Fonction pour gérer la connexion
  Future<void> login() async {
    try {
      await ApiService().login(myController.text, passwordController.text);
      print('Login successful');
      await ApiService().fetchPlayerInfo();
      print('Player info fetched');
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Hub()),
      );
    } catch (error) {
      showErrorDialog('Erreur de connexion. Veuillez réessayer.');
    }
  }

  // Fonction pour gérer l'inscription
  Future<void> register() async {
    try {
      await ApiService().register(myController.text, passwordController.text);
     login();
    } catch (error) {
      showErrorDialog('Erreur d\'inscription. Veuillez réessayer.');
    }
  }

  // Fonction pour afficher une boîte de dialogue en cas d'erreur
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
              Image.asset(
                'assets/images/robotLogo.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Champ pour le pseudo
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: myController,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: 'Saisir le pseudo',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Champ pour le mot de passe
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: passwordController,
                      textAlign: TextAlign.center,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: 'Saisir le mot de passe',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Bouton de connexion
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: login,
                      child: Text('Connexion'),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Bouton d'inscription
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: register,
                      child: Text('Inscription'),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFe77708)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
