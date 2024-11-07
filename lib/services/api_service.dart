import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piction_ia_ry/services/data.dart' as data;

class ApiService {
  final String baseUrl = 'https://pictioniary.wevox.cloud/api';

  // Votre token d'authentification
  final String token = data.token;

  // Méthode pour configurer les en-têtes
  Map<String, String> _headers() {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // Méthode pour se connecter
  Future<void> login(String name, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final _data = jsonDecode(response.body);
      data.token = _data['token']; // Récupérer le JWT
    } else {
      throw Exception('Failed to login');
    }
  }

  // Méthode pour s'inscrire
  Future<void> register(String name, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/players'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'password': password,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register');
    }
  }

  // Méthode pour récupérer les informations du joueur
  Future<void> fetchPlayerInfo() async {
    final response = await http.get(Uri.parse('$baseUrl/me'), headers: _headers());

    if (response.statusCode == 200) {
      final _data = json.decode(response.body);
      data.username = _data['name'];
      data.userId = _data['id'];
    } else {
      throw Exception('Failed to fetch player info');
    }
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
  Future<Map<String, List<int>>> joinGameSession(String sessionId, String color) async {
    final response = await http.post(
      Uri.parse('$baseUrl/game_sessions/$sessionId/join'),
      headers: _headers(),
      body: json.encode({'color': color}),
    );

    if (response.statusCode == 200) {
      final _data = json.decode(response.body);
      return {
        'blue_team': List<int>.from(_data['blue_team']),
        'red_team': List<int>.from(_data['red_team']),
      };
    } else {
      throw Exception('Failed to join game session');
    }
  }


}
