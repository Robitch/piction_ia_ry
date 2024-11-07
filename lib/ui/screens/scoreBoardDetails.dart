import 'package:flutter/material.dart';

class ScoreBoardDetails extends StatelessWidget {
  final List<Map<String, dynamic>> propositions = [
    {'phrase': 'Une bête sur un mur', 'score': 25},
    {'phrase': 'Un chien dans le jardin', 'score': -8},
    {'phrase': 'Un chat dans l’arbre', 'score': 15},
  ];

  @override
  Widget build(BuildContext context) {
    // Calcul du score total
    int totalScore = propositions.fold(0, (sum, item) => (sum + item['score'] as num).toInt());
    bool isPositive = totalScore >= 0;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Détails du Score"),
            const SizedBox(width: 10),
            Text(
              '${isPositive ? '+' : ''}$totalScore', // Affichage du score avec un + si positif
              style: TextStyle(
                color: isPositive ? Colors.green : Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        color: Colors.grey[200], // Fond gris
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image sous le titre
            Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/imageExample.jpg', // Remplace par le chemin de ton image
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Titre "Prompt utilisé"
            const Text(
              'Prompt utilisé',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 10),

            // Texte sous "Prompt utilisé"
            const Text(
              'Le piag ingrédient de base des menus KFC sur des briques empilées',
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Titre "Propositions faites"
            const Text(
              'Propositions faites',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 10),

            // Liste des propositions
            Expanded(
              child: ListView.builder(
                itemCount: propositions.length,
                itemBuilder: (context, index) {
                  final proposition = propositions[index];
                  final score = proposition['score'];
                  final isPositive = score >= 0;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        proposition['phrase'],
                        style: const TextStyle(fontSize: 18),
                      ),
                      trailing: Text(
                        '${isPositive ? '+' : ''}$score',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isPositive ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
