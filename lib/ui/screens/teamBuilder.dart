import 'package:flutter/material.dart';
import 'package:piction_ia_ry/services/api_service.dart';
import 'package:piction_ia_ry/services/data.dart' as data;
import 'package:qr_flutter/qr_flutter.dart';

class TeamBuilder extends StatefulWidget {
  final String gameSessionId;

  const TeamBuilder({super.key, required this.gameSessionId});

  @override
  State<TeamBuilder> createState() => _TeamBuilderState();
}

class _TeamBuilderState extends State<TeamBuilder> {
  List<int> teamBlue = [];
  List<int> teamOrange = [];
  bool isGameReady = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _fetchTeamData();
  }

  Future<void> _fetchTeamData() async {
    try {
      final teamData = await ApiService().getGameSession(widget.gameSessionId);
      setState(() {
        teamBlue = teamData['blue_team'] ?? [];
        teamOrange = teamData['red_team'] ?? [];
        _checkGameReady();
      });
    } catch (e) {
      print('Error fetching team data: $e');
    }
  }

  Future<void> _joinTeam(String teamColor) async {
    bool isOnTeamBlue = teamBlue.contains(data.userId);
    bool isOnTeamOrange = teamOrange.contains(data.userId);

    print('isOnTeamBlue: $isOnTeamBlue');
    print('isOnTeamOrange: $isOnTeamOrange');

      if ((teamColor == 'blue' && isOnTeamOrange) ||
          (teamColor == 'red' && isOnTeamBlue)) {
        try {
          await ApiService().leaveGameSession(widget.gameSessionId);
          print('Left previous team successfully.');
        } catch (e) {
          print('Error leaving team: $e');
          return;
        }
      }

      // Now attempt to join the selected team
      try {
        final teamData =
        await ApiService().joinGameSession(widget.gameSessionId, teamColor);
        setState(() {
          teamBlue = teamData['blue_team'] ?? [];
          teamOrange = teamData['red_team'] ?? [];
          _checkGameReady();
        });
      } catch (e) {
        print('Error joining team: $e');
      }
  }


  void _checkGameReady() {
    setState(() {
      isGameReady = teamBlue.length == 2 && teamOrange.length == 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Builder'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            try {
              // Appelle l'API pour quitter la session de jeu
              await ApiService().leaveGameSession(widget.gameSessionId);
              print('Session de jeu quittée avec succès.');
            } catch (e) {
              print('Erreur lors de la déconnexion : $e');
            } finally {
              // Retour à l'écran précédent
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'ID de la Session de Jeu: ${widget.gameSessionId}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            _buildQRCode(widget.gameSessionId),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: _buildTeamCard(
                      'Équipe Bleue',
                      Colors.blue,
                      teamBlue,
                          () => _joinTeam('blue'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: _buildTeamCard(
                      'Équipe Orange',
                      Colors.orange,
                      teamOrange,
                          () => _joinTeam('red'),
                    ),
                  ),
                ],
              ),
            ),
            if (isGameReady)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    'Lancer la Partie',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamCard(String teamName, Color color, List<int> teamMembers, VoidCallback onJoinPressed) {
    return Card(
      color: color.withOpacity(0.9),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  teamName,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (teamMembers.length < 2)
                  ElevatedButton(
                    onPressed: onJoinPressed,
                    child: Text('Rejoindre'),
                  ),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: teamMembers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Player ${teamMembers[index]}',
                      style: TextStyle(fontSize: 16),
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

  Widget _buildQRCode(String gameSessionId) {
    return QrImageView(
      data: gameSessionId,
      version: QrVersions.auto,
      size: 200,
      gapless: false,
    );
  }
}
