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
  bool isActive = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    isActive = false;
    super.dispose();
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

    await Future.delayed(const Duration(seconds:  5));
    _fetchTeamData();
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
        title: Text('Session de jeu [ID: ${widget.gameSessionId}]'),
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
           // Text(
             // 'ID de la Session de Jeu: ${widget.gameSessionId}',
              // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            //_buildQRCode(widget.gameSessionId) sous forme de card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                        child: _buildQRCode(widget.gameSessionId),
                    ),
            ),

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
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: isGameReady ? () => {} : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Icon(Icons.add),
                      Text(isGameReady ? 'Lancer la partie' : 'En attente de joueurs'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    backgroundColor: Color(0xFFe77708),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.white,
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
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (teamMembers.length < 2 && !teamMembers.contains(data.userId))
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
      size: 150,
      gapless: false,
    );
  }
}
