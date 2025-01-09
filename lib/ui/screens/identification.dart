import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:piction_ia_ry/ui/screens/queue.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piction_ia_ry/services/api_service.dart';
import 'package:piction_ia_ry/ui/screens/hub.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Identification extends StatefulWidget {
  const Identification({super.key});

  @override
  State<Identification> createState() => _IdentificationState();
}

class _IdentificationState extends State<Identification> {
  final myController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Fonction pour afficher le loader
  void showLoader(String waitingText) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Queue(waitingText: waitingText),
        );
      },
    );
  }

  // Fonction pour cacher le loader
  void hideLoader() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  // Fonction pour gérer la connexion
  Future<void> login() async {
    showLoader('Connexion en cours...');
    try {
      await ApiService().login(myController.text, passwordController.text);
      await ApiService().fetchPlayerInfo();
      hideLoader(); // Masquer le loader
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Hub()),
      );
    } catch (error) {
      hideLoader(); // Masquer le loader en cas d'erreur
      showErrorDialog('Erreur de connexion. Veuillez réessayer.');
    }
  }

  // Fonction pour gérer l'inscription
  Future<void> register() async {
    showLoader('Inscription en cours...');
    try {
      await ApiService().register(myController.text, passwordController.text);
      hideLoader(); // Masquer le loader après inscription réussie
      login(); // Appeler la fonction login
    } catch (error) {
      hideLoader(); // Masquer le loader en cas d'erreur
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
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: login,
                      child: Text('Connexion'),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(20)),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: register,
                      child: Text('Inscription'),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.all(20)),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFe77708)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
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
