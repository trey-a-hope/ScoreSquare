import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/blocs/game/game_bloc.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/models/nba_team_model.dart';
import 'package:score_square/services/format_service.dart';

import '../constants.dart';
import '../service_locator.dart';

class GameListTile extends StatelessWidget {
  final GameModel game;

  const GameListTile({
    Key? key,
    required this.game,
  }) : super(key: key);

  String _buildSubTitle() {
    switch (game.status) {
      case -1:
        return 'Game starts at ${locator<FormatService>().yMMMd(date: game.starts)}';
      case 0:
        return '${game.homeTeamScore} - ${game.awayTeamScore}, ${game.betCount} bets';
      case 1:
        return 'Winner: TODO';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    NBATeamModel homeTeam =
        nbaTeams.firstWhere((team) => team.id == game.homeTeamID);
    NBATeamModel awayTeam =
        nbaTeams.firstWhere((team) => team.id == game.awayTeamID);

    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (BuildContext context) => GameBloc(
                game: game,
                homeTeam: homeTeam,
                awayTeam: awayTeam,
              )..add(
                  LoadPageEvent(),
                ),
              child: const GamePage(),
            ),
          ),
        );
      },
      title: Text('${homeTeam.name} vs. ${awayTeam.name}'),
      subtitle: Text(_buildSubTitle()),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
