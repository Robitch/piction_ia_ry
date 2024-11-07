import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://pictioniary.wevox.cloud/api';

  // Votre token d'authentification
  final String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NTUsIm5hbWUiOiJSb2JpbiJ9.DGFj4ftcW8McFAUTII1ujIY42_r7OsLICVOXjiGfYnI';

  // Méthode pour configurer les en-têtes
  Map<String, String> _headers() {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // Méthode pour créer une session de jeu
  Future<String> createGameSession() async {
    final response = await http.post(
      Uri.parse('$baseUrl/game_sessions'),
      headers: _headers(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      return data['id'].toString(); // Renvoie l'ID de la session
    } else {
      throw Exception('Failed to create game session');
    }
  }

  // Méthode pour rejoindre une session de jeu
  Future<void> joinGameSession(String sessionId, String color) async {
    final response = await http.post(
      Uri.parse('$baseUrl/game_sessions/$sessionId/join'),
      headers: _headers(),
      body: json.encode({'color': color}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Joined game session: $data'); // Pour le debug
    } else {
      throw Exception('Failed to join game session');
    }
  }


}
