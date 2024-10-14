import 'package:flutter/material.dart';
import 'package:piction_ia_ry/ui/screens/hub.dart';
import 'package:google_fonts/google_fonts.dart';

class Identification extends StatefulWidget {
  const Identification({super.key});

  @override
  State<Identification> createState() => _IdentificationState();
}

class _IdentificationState extends State<Identification> {
  final myController = TextEditingController();
  final passwordController = TextEditingController(); // Controller pour le mot de passe

  @override
  void dispose() {
    myController.dispose();
    passwordController.dispose(); // Dispose du contrôleur de mot de passe
    super.dispose();
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
                'assets/images/robotLogo.png', // Remplace par le chemin de ton image
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
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: 'Saisir le pseudo',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
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
                      obscureText: true, // Masque le texte
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: 'Saisir le mot de passe',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Bouton d'enregistrement
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const Hub()),
                        );
                      },
                      child: Text('Enregistrer'),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20)), // padding
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFe77708)), // Couleur orange
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Couleur du texte
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
