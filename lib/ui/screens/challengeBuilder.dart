import 'package:flutter/material.dart';

class Challenge {
  String title;
  String phrase;
  List<String> forbiddenWords;

  Challenge({
    required this.title,
    required this.phrase,
    required this.forbiddenWords,
  });
}

class ChallengeBuilder extends StatefulWidget {
  const ChallengeBuilder({super.key});

  @override
  State<ChallengeBuilder> createState() => _ChallengeBuilderState();
}

class _ChallengeBuilderState extends State<ChallengeBuilder> {
  List<Challenge?> challenges = List.generate(4, (index) => null);
  String errorMessage = "error message";
  bool showErrorMessage = false;

  void _showChallengeDialog(int index) {
    // Variables pour suivre les sélections
    String selectedGender1 = "un";
    String selectedLocation = "sur";
    String selectedGender2 = "un";

    // Contrôleurs pour les TextFields
    TextEditingController word1Controller = TextEditingController();
    TextEditingController word2Controller = TextEditingController();
    TextEditingController forbiddenWord1Controller = TextEditingController();
    TextEditingController forbiddenWord2Controller = TextEditingController();
    TextEditingController forbiddenWord3Controller = TextEditingController();

    // Si le challenge est déjà défini, remplir les champs avec les valeurs actuelles
    if (challenges[index] != null) {
      final challenge = challenges[index]!;
      final words = challenge.phrase.split(" ");
      selectedGender1 = words[0];
      word1Controller.text = words[1];
      selectedLocation = words[2];
      selectedGender2 = words[3];
      word2Controller.text = words[4];

      // Remplir les champs des mots interdits
      forbiddenWord1Controller.text = challenge.forbiddenWords[0];
      forbiddenWord2Controller.text = challenge.forbiddenWords[1];
      forbiddenWord3Controller.text = challenge.forbiddenWords[2];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Configurer le challenge'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _CustomToggle(
                    options: const ['un', 'une'],
                    selectedOption: selectedGender1,
                    onChanged: (value) {
                      setState(() {
                        selectedGender1 = value;
                      });
                    },
                  ),
                  TextField(
                    controller: word1Controller,
                    decoration: const InputDecoration(hintText: 'Premier mot'),
                  ),
                  _CustomToggle(
                    options: const ['sur', 'dans'],
                    selectedOption: selectedLocation,
                    onChanged: (value) {
                      setState(() {
                        selectedLocation = value;
                      });
                    },
                  ),
                  _CustomToggle(
                    options: const ['un', 'une'],
                    selectedOption: selectedGender2,
                    onChanged: (value) {
                      setState(() {
                        selectedGender2 = value;
                      });
                    },
                  ),
                  TextField(
                    controller: word2Controller,
                    decoration: const InputDecoration(hintText: 'Deuxième mot'),
                  ),
                  const SizedBox(height: 10),
                  const Text('Mots interdits (3 mots)'),
                  TextField(
                    controller: forbiddenWord1Controller,
                    decoration: InputDecoration(
                      hintText: 'Mot interdit 1',
                      hintStyle: TextStyle(color: forbiddenWord1Controller.text.isEmpty ? Colors.black : Colors.red),
                    ),
                    style: TextStyle(color: forbiddenWord1Controller.text.isEmpty ? Colors.black : Colors.red),
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                  TextField(
                    controller: forbiddenWord2Controller,
                    decoration: InputDecoration(
                      hintText: 'Mot interdit 2',
                      hintStyle: TextStyle(color: forbiddenWord2Controller.text.isEmpty ? Colors.black : Colors.red),
                    ),
                    style: TextStyle(color: forbiddenWord2Controller.text.isEmpty ? Colors.black : Colors.red),
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                  TextField(
                    controller: forbiddenWord3Controller,
                    decoration: InputDecoration(
                      hintText: 'Mot interdit 3',
                      hintStyle: TextStyle(color: forbiddenWord3Controller.text.isEmpty ? Colors.black : Colors.red),
                    ),
                    style: TextStyle(color: forbiddenWord3Controller.text.isEmpty ? Colors.black : Colors.red),
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),
                  // Réserver de l'espace pour le message d'erreur
                  const SizedBox(height: 20),
                  if (showErrorMessage)
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Valider'),
              onPressed: () {
                // Validation : vérifier que tous les champs sont remplis
                if (word1Controller.text.isNotEmpty &&
                    word2Controller.text.isNotEmpty &&
                    forbiddenWord1Controller.text.isNotEmpty &&
                    forbiddenWord2Controller.text.isNotEmpty &&
                    forbiddenWord3Controller.text.isNotEmpty) {
                  // Construire la phrase à partir des sélections
                  String phrase =
                      "$selectedGender1 ${word1Controller.text} $selectedLocation $selectedGender2 ${word2Controller.text}";

                  // Créer le challenge avec les mots interdits
                  setState(() {
                    challenges[index] = Challenge(
                      title: "Challenge ${index + 1}",
                      phrase: phrase,
                      forbiddenWords: [
                        forbiddenWord1Controller.text,
                        forbiddenWord2Controller.text,
                        forbiddenWord3Controller.text,
                      ],
                    );
                    errorMessage = ""; // Réinitialiser le message d'erreur
                    showErrorMessage = false; // Masquer le message d'erreur
                  });
                  Navigator.of(context).pop();
                } else {
                  setState(() {
                    errorMessage = "Veuillez remplir tous les champs !"; // Afficher le message d'erreur
                    showErrorMessage = true; // Afficher le message d'erreur
                  });

                  // Cacher le message d'erreur après 2 secondes

                  //Future.delayed(const Duration(seconds: 2), () {
                    //setState(() {
                      //showErrorMessage = false;
                    //});
                  //});

                }
              },
            ),
          ],
        );
      },
    );
  }

  bool _areAllChallengesValidated() {
    return challenges.every((challenge) => challenge != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge Builder'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: challenges.length,
              itemBuilder: (context, index) {
                final challenge = challenges[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 60),
                      backgroundColor: challenge == null
                          ? Colors.grey[300]
                          : Colors.orange,
                    ),
                    onPressed: () => _showChallengeDialog(index),
                    child: Text(
                      challenge?.phrase ?? "Challenge ${index + 1} ?",
                      style: TextStyle(
                        color: challenge == null ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity,70),
              textStyle: const TextStyle(fontSize: 20 , color: Colors.white),
              backgroundColor: _areAllChallengesValidated()
                  ? Colors.green
                  : Colors.grey,
            ),
            onPressed: _areAllChallengesValidated()
                ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Challenges validés avec succès !"),
                ),
              );
            }
                : null,
              //bouton pret
            child:
            const Text('Pret !'),
          ),
        ],
      ),
    );
  }
}

class _CustomToggle extends StatelessWidget {
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onChanged;

  const _CustomToggle({
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: options.map((option) {
          final isSelected = option == selectedOption;
          return GestureDetector(
            onTap: () => onChanged(option),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                option,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
