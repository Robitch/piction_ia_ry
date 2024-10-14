import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Queue extends StatefulWidget {
  final String waitingText; // Paramètre texte

  const Queue({super.key, required this.waitingText});

  @override
  State<Queue> createState() => _QueueState();
}

class _QueueState extends State<Queue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3aa5bc), // Couleur de fond personnalisée
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.waitingText, // Utilisation du texte passé en paramètre
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20), // Espacement entre le texte et l'animation
            LoadingAnimationWidget.bouncingBall(
              color: Colors.orange,
              size: 80, // Taille de l'animation
            ),
          ],
        ),
      ),
    );
  }
}
