import 'package:flutter/material.dart';
import 'package:score_square/models/game_model.dart';

class GameListTile extends StatelessWidget {
  final GameModel game;
  final VoidCallback onTap;

  const GameListTile({
    Key? key,
    required this.game,
    required this.onTap,
  }) : super(key: key);

  String _buildSubTitle() {
    switch (game.status()) {
      case 0:
        return game.startDate();
      case 1:
        return game.details();
      case 2:
        return 'Winner: TODO';
      case 3:
      default:
        return 'Winner: TODO';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(game.homeTeam().imgUrl),
      ),
      trailing: CircleAvatar(
        backgroundImage: NetworkImage(game.awayTeam().imgUrl),
      ),
      title: Text(
        game.toString(),
        style: const TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
      subtitle: Text(
        _buildSubTitle(),
        textAlign: TextAlign.center,
      ),
      onTap: onTap,
    );
  }
}
