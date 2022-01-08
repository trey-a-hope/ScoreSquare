import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:score_square/models/game_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:score_square/theme.dart';
import '../../constants.dart';

class GameListTile extends StatelessWidget {
  final GameModel game;
  final VoidCallback? onTap;
  final SlidableAction? slidableAction;
  final Widget? openBuilder;

  const GameListTile({
    Key? key,
    required this.game,
    this.onTap,
    this.slidableAction,
    this.openBuilder,
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OpenContainer(
          closedElevation: 5,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: game.homeTeam().color,
              width: 2,
            ),
          ),
          transitionType: ContainerTransitionType.fade,
          transitionDuration: const Duration(
            milliseconds: transitionDuration,
          ),
          openBuilder: (context, action) {
            if (openBuilder != null) {
              return openBuilder!;
            } else {
              return Container();
            }
          },
          closedBuilder: (context, action) => ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(game.homeTeam().imgUrl),
            ),
            trailing: CircleAvatar(
              backgroundImage: NetworkImage(game.awayTeam().imgUrl),
            ),
            title: Text(
              game.toString(),
              style: textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              _buildSubTitle(),
              style: textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
