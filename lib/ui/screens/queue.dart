import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Queue extends StatefulWidget {
  final String waitingText;

  const Queue({super.key, required this.waitingText});

  @override
  State<Queue> createState() => _QueueState();
}

class _QueueState extends State<Queue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Fond transparent si nécessaire
      body: Center(
        child: Container(
          width: 200, // Largeur du carré
          height: 200, // Hauteur du carré
          decoration: BoxDecoration(
            color: Colors.white, // Couleur de fond du carré
            borderRadius: BorderRadius.circular(20), // Arrondir les coins si nécessaire
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Ajout d'un espacement interne
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.waitingText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                LoadingAnimationWidget.bouncingBall(
                  color: Colors.orange,
                  size: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
