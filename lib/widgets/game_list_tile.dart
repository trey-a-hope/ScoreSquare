import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/blocs/game/game_bloc.dart';
import 'package:score_square/models/game_model.dart';

class GameListTile extends StatelessWidget {
  final GameModel game;

  const GameListTile({
    Key? key,
    required this.game,
  }) : super(key: key);

  String _buildSubTitle() {
    switch (game.status) {
      case -1:
        return game.startDate();
      case 0:
        return game.details();
      case 1:
        return 'Winner: TODO';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (BuildContext context) => GameBloc(
                gameID: game.id!,
                homeTeam: game.homeTeam(),
                awayTeam: game.awayTeam(),
              )..add(
                  LoadPageEvent(),
                ),
              child: const GamePage(),
            ),
          ),
        );
      },
      title: Text('${game.homeTeam().name} vs. ${game.awayTeam().name}'),
      subtitle: Text(_buildSubTitle()),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
