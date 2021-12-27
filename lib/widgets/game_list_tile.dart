import 'package:flutter/material.dart';
import 'package:score_square/models/game_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GameListTile extends StatelessWidget {
  final GameModel game;
  final VoidCallback onTap;
  final SlidableAction? slidableAction;

  const GameListTile({
    Key? key,
    required this.game,
    required this.onTap,
    this.slidableAction,
  }) : super(key: key);

  String _buildSubTitle() {
    switch (game.status()) {
      //Not started.
      case 0:
        return game.startDate();
      //Active.
      case 1:
      //Ended.
      case 2:
      //Claimed.
      case 3:
      default:
        return game.details();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: slidableAction != null,
      key: ValueKey(game.hashCode),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          if (slidableAction != null) ...[
            slidableAction!,
          ]
        ],
      ),
      child: ListTile(
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
      ),
    );
  }
}
