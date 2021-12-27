import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/blocs/create_game/create_game_bloc.dart'
    as create_game;
import 'package:score_square/blocs/update_game/update_game_bloc.dart'
    as update_game;
import 'package:score_square/blocs/claim_winners/claim_winners_bloc.dart'
    as claim_winners_game;
import 'package:score_square/models/game_model.dart';
import 'package:score_square/pages/select_game_page.dart';
import 'package:score_square/services/game_service.dart';
import '../service_locator.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  _AdminPageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Admin Page'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (BuildContext context) =>
                        create_game.CreateGameBloc()
                          ..add(create_game.LoadPageEvent()),
                    child: const create_game.CreateGamePage(),
                  ),
                ),
              );
            },
            leading: const Icon(Icons.sports_basketball),
            subtitle: const Text('Create a new game for users to bet on.'),
            title: const Text('Create Game'),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (BuildContext context) =>
                        claim_winners_game.ClaimWinnersBloc()
                          ..add(claim_winners_game.LoadPageEvent()),
                    child: const claim_winners_game.ClaimWinnersPage(),
                  ),
                ),
              );
            },
            leading: const Icon(Icons.face),
            subtitle:
                const Text('Give coins to winners and send notification.'),
            title: const Text('Claim Winners'),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () async {
              List<GameModel> games = await locator<GameService>().list();

              Route route = MaterialPageRoute(
                builder: (BuildContext context) => SelectGamePage(games: games),
              );

              final result = await Navigator.push(context, route);

              if (result == null) return;

              final selectedGame = result as GameModel;

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (BuildContext context) =>
                        update_game.UpdateGameBloc(gameID: selectedGame.id!)
                          ..add(update_game.LoadPageEvent()),
                    child: const update_game.UpdateGamePage(),
                  ),
                ),
              );
            },
            leading: const Icon(Icons.update),
            subtitle: const Text(
                'Modify score, status, and other details about game.'),
            title: const Text('Update Game'),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.attach_money),
            subtitle: const Text('Add coins to a user account.'),
            title: const Text('Give Coins'),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
