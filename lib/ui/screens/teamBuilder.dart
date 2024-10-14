import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamBuilder extends StatefulWidget {
  const TeamBuilder({super.key});

  @override
  State<TeamBuilder> createState() => _TeamBuilderState();
}
 class _TeamBuilderState extends State<TeamBuilder> {
  @override
  Widget build(BuildContext context) {
  return GestureDetector(
  onTap: () {
  FocusScope.of(context).unfocus();
  },
  child: Scaffold(
  appBar: AppBar(
  title: Text('Queue', style: GoogleFonts.cabinSketch(fontSize: 28)),
  centerTitle: true,
  backgroundColor: Colors.orange,
  ),
  body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  // Title
  Text(
  'Queue',
  style: GoogleFonts.cabinSketch(
  fontSize: 50,
  fontWeight: FontWeight.bold,
  ),
  ),
  SizedBox(height: 30),
  // Team 1 List
  Expanded(
  child: Column(
  children: [
  Text(
  'Équipe Bleu',
  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  ),
  SizedBox(height: 10),
  _buildTeamList(['Joueur 1', 'Joueur 2']),
  ],
  ),
  ),
  // Team 2 List
  Expanded(
  child: Column(
  children: [
  Text(
  'Équipe Orange',
  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  ),
  SizedBox(height: 10),
  _buildTeamList(['Joueur 3', 'Joueur 4']),
  ],
  ),
  ),
  ],
  ),
  ),
  ),
  );
  }

  Widget _buildTeamList(List<String> players) {
  return Column(
  children: players
      .map((player) => Card(
  child: ListTile(
  title: Text(player),
  trailing: IconButton(
  icon: Icon(Icons.delete),
  onPressed: () {
  setState(() {
  players.remove(player);
  });
  },
  ),
  ),
  ))
      .toList(),
  );
  }
  }