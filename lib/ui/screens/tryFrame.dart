import 'package:flutter/material.dart';

class TryFrame extends StatefulWidget {
  const TryFrame({super.key});

  @override
  State<TryFrame> createState() => _TryFrameState();
}

class _TryFrameState extends State<TryFrame> {
  // Args:
  //{
  //"first_word" : "une",
  //"second_word" : "poule",
  //"third_word" : "sur",
  //"fourth_word" : "un",
  //"fifth_word" : "mur",
  //"forbidden_words" : ["volaille", "brique", "poulet"]
  //}

  final List<Map<String, dynamic>> words = [
    {"label": "une", "guessable": false},
    {"label": "poule", "guessable": true},
    {"label": "sur", "guessable": false},
    {"label": "un", "guessable": false},
    {"label": "mur", "guessable": true}
  ];
  final List<String> forbiddenWords = ["volaille", "brique", "poulet"];

  String inputText = "";
  List<String> attempts = [];
  Map<String, String> guessedWords = {};

  void checkAnswer() {
    final answer = words
        .map((word) =>
            word['guessable'] ? guessedWords[word['label']] : word['label'])
        .join(' ');
    print(answer);

    setState(() {
      attempts.add(answer);
    });

    // display snackbar if answer is correct
    if (answer == words.map((word) => word['label']).join(' ')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bravo !'),
          //success color
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dommage !'),
          //error color
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void resetGame() {
    setState(() {
      // Réinitialise les mots remplis
      // Concatène les mots qui ne sont pas à deviner, avec des astérisques pour ce qui sont à deviner
    });
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
          child: SingleChildScrollView(
            // Ajout d'un défilement
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 20), // Espacement de 20px

                // Card avec challenge et scores
                Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      // Première moitié avec fond bleu
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/3116/3116411.png',
                                    width: 50,
                                  ), // Icône de l'équipe 1
                                ],
                              ),
                              const SizedBox(width: 20),
                              const Text(
                                '90',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Deuxième moitié avec fond orange
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: const BoxDecoration(
                            color: Color(0xFFe77708),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '63',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/1902/1902222.png',
                                    width: 50,
                                  ), // Icône de l'équipe 2
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20), // Espacement de 20px

                // Image en carré
                Container(
                  width: double.infinity,
                  height: 200, // Ajout d'une hauteur fixe pour éviter l'erreur
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://p.potaufeu.asahi.com/1831-p/picture/27695628/89644a996fdd0cfc9e06398c64320fbe.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Espacement de 20px

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Text(
                      // inputText.replaceAll('******', '_______'), // Remplace les astérisques par des tirets
                      // style: TextStyle(fontSize: 18),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(words.length, (index) {
                          final word = words[index];
                          if (word['guessable'] == false) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Text(
                                word['label'],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: forbiddenWords.contains(word['label'])
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                            );
                          } else {
                            return Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      guessedWords[word['label']] = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: '____',
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(8),
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: checkAnswer,
                        child: Text('Valider'),
                      ),
                      const SizedBox(height: 20),
                      attempts.isNotEmpty
                          ? SizedBox(
                        height: 200, // Limite la hauteur de la liste à 200 pixels
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200], // Arrière-plan doux
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3), // Ombre légère
                              ),
                            ],
                          ),
                          child: Scrollbar(
                            thickness: 6,
                            radius: Radius.circular(10),
                            thumbVisibility: true, // Rendre la barre visible en permanence
                            child: ListView.separated(
                              itemCount: attempts.length,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              separatorBuilder: (context, index) => Divider(
                                color: Colors.grey[300],
                                thickness: 1, // Séparateur entre les éléments
                                indent: 10,
                                endIndent: 10,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    title: Text(
                                      attempts[index],
                                      style: TextStyle(fontSize: 16, color: Colors.black87),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blueAccent, // Couleur du numéro
                                      foregroundColor: Colors.white,
                                      child: Text(
                                        (index + 1).toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                          : SizedBox.shrink(), // Si attempts est vide, on affiche un widget vide

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
