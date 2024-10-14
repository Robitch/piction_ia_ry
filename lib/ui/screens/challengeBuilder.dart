import 'package:flutter/material.dart';
import 'package:fk_toggle/fk_toggle.dart';

class Challenge {
  String title;
  int number;
  String phrase;
  List<String> forbiddenWords;

  Challenge({
    required this.title,
    required this.number,
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
  List<Challenge> challenges = [];

  void _addChallenge(String title, String phrase, List<String> forbiddenWords) {
    setState(() {
      challenges.add(
        Challenge(
          title: title,
          number: challenges.length + 1,
          phrase: phrase,
          forbiddenWords: forbiddenWords,
        ),
      );
    });
  }

  void _deleteChallenge(int index) {
    setState(() {
      challenges.removeAt(index);
    });
  }

  void _showAddChallengeDialog() {
    String selectedGender1 = "un";
    String selectedLocation = "sur";
    String selectedGender2 = "un";
    TextEditingController word1Controller = TextEditingController();
    TextEditingController word2Controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter un nouveau challenge'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FkToggle(
                    width: 50,
                    height: 30,
                    labels: const ['un', 'une'],
                      selectedColor : Colors.orange
                  ),
                ],
              ),
              TextField(
                controller: word1Controller,
                decoration: const InputDecoration(hintText: 'Premier mot'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FkToggle(
                    width: 50,
                    height: 30,
                    labels: const ['sur', 'dans'],
                      selectedColor : Colors.orange

                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FkToggle(
                    width: 50,
                    height: 30,
                    labels: const ['un', 'une'],
                      selectedColor : Colors.orange

                  ),
                ],
              ),
              TextField(
                controller: word2Controller,
                decoration: const InputDecoration(hintText: 'Deuxième mot'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ajouter'),
              onPressed: () {
                String phrase =
                    "$selectedGender1 ${word1Controller.text} $selectedLocation $selectedGender2 ${word2Controller.text}";
                _addChallenge("Challenge", phrase, []);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge Builder'),
      ),
      body: ListView.builder(
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text("${challenges[index].title} - #${challenges[index].number}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phrase à trouver : ${challenges[index].phrase}"),
                  Text("Mots interdits : ${challenges[index].forbiddenWords.join(', ')}"),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteChallenge(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddChallengeDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
