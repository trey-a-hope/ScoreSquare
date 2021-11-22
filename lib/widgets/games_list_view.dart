import 'package:flutter/material.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/widgets/game_list_tile.dart';

class GamesListView extends StatelessWidget {
  final List<GameModel> games;

  const GamesListView({
    Key? key,
    required this.games,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (context, index) {
        return GameListTile(game: games[index]);
      },
    );
  }
}
