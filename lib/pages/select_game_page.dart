import 'package:flutter/material.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/widgets/game_list_tile.dart';

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

          return GameListTile(
            game: game,
            onTap: () {
              Navigator.of(context).pop(game);
            },
          );
        },
      ),
    );
  }
}
