import 'package:flutter/material.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/models/nba_team_model.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/widgets/basic_page.dart';
import 'package:score_square/widgets/list_tiles/game_list_tile.dart';
import 'package:score_square/widgets/list_tiles/nba_team_list_tile.dart';
import 'package:score_square/widgets/list_tiles/user_list_tile.dart';

class SelectItemPage extends StatelessWidget {
  final List items;
  final String type; //User, Game, Team

  const SelectItemPage({
    Key? key,
    required this.items,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      child: items.isEmpty
          ? const Center(
              child: Text('No Items...'),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                switch (type) {
                  case 'User':
                    UserModel user = items[index] as UserModel;
                    return UserListTile(
                      onTap: () {
                        Navigator.of(context).pop(user);
                      },
                      user: user,
                    );
                  case 'Game':
                    GameModel game = items[index] as GameModel;
                    return GameListTile(
                      game: game,
                      onTap: () {
                        Navigator.of(context).pop(game);
                      },
                    );
                  case 'Team':
                    NBATeamModel team = items[index] as NBATeamModel;
                    return NBATeamListTile(
                      onTap: () {
                        Navigator.of(context).pop(team);
                      },
                      team: team,
                    );
                  default:
                    return Container();
                }
              },
            ),
      title: 'Select $type',
    );
  }
}
