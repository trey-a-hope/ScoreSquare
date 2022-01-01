import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/blocs/game/game_bloc.dart';

import 'list_tiles/game_list_tile.dart';

class GamesListView extends StatelessWidget {
  final List<GameModel> games;

  const GamesListView({
    Key? key,
    required this.games,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return games.isEmpty
        ? const Center(
            child: Text('No Games'),
          )
        : ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              GameModel game = games[index];
              return GameListTile(
                game: games[index],
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (BuildContext context) => GameBloc(
                          gameID: game.id!,
                        )..add(
                            LoadPageEvent(),
                          ),
                        child: const GamePage(),
                      ),
                    ),
                  );
                },
              );
            },
          );
  }
}
