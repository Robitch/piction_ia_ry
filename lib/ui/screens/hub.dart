import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Hub extends StatefulWidget {
  const Hub({super.key});

  @override
  State<Hub> createState() => _HubState();
}

class _HubState extends State<Hub> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'PICTION.IA.RY',
                style: TextStyle(
                  fontSize: 60,
                  fontFamily: GoogleFonts.cabinSketch().fontFamily,
                ),
              ),
              Text(
                'Bonjour, pseudo',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const Hub())
                        );
                      },
                      child: Text('Enregistrer'),
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20)), //padding
                        //blue color, rounded borders white border 2 px, text color white
                        backgroundColor: WidgetStateProperty.all<Color>(Color(0xFFe77708)), //blue color
                        shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                        foregroundColor: WidgetStateProperty.all<Color>(Colors.white), //text color white
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const Hub())
                        );
                      },
                      child: Text('Enregistrer'),
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20)), //padding
                        //blue color, rounded borders white border 2 px, text color white
                        backgroundColor: WidgetStateProperty.all<Color>(Color(0xFFe77708)), //blue color
                        shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                        foregroundColor: WidgetStateProperty.all<Color>(Colors.white), //text color white
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

