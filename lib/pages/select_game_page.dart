import 'package:flutter/material.dart';
import 'package:score_square/models/game_model.dart';

//TODO: Make this generic.
class SelectGamePage extends StatelessWidget {
  final List<GameModel> games;

  const SelectGamePage({
    Key? key,
    required this.games,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Select a game'),
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (BuildContext context, int index) {
          GameModel game = games[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(game.homeTeam().imgUrl),
            ),
            title: Text(
              game.toString(),
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: Text(game.details()),
            onTap: () {
              Navigator.pop(context, game);
            },
          );
        },
      ),
    );
  }
}
