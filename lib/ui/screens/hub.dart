import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piction_ia_ry/ui/screens/scanner.dart';
import 'package:piction_ia_ry/ui/forms/create_form.dart';


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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'PICTION.IA.RY',
                style: TextStyle(
                  fontSize: 60,
                  fontFamily: GoogleFonts.cabinSketch().fontFamily,
                ),
              ),
              // Text(
              //   'Bonjour, pseudo',
              //   style: TextStyle(
              //     fontSize: 24,
              //   ),
              // ),
              // Image + text
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: NetworkImage('https://img.freepik.com/premium-vector/pencil-robot-logo_92637-150.jpg'),
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Ajout d\'un challenge'),
                              content: MyForm(),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                              Icons.add,
                          ),
                          Text('Créer une partie'),
                        ],
                      ),
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
                            MaterialPageRoute(builder: (context) => const QRViewExample())
                        );
                      },
                      //icon + text
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                              Icons.qr_code,
                          ),
                          Text('Rejoindre une partie'),
                        ],
                      ),
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

