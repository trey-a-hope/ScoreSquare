import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/blocs/create_game/create_game_bloc.dart'
    as create_game;

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
            onTap: () {},
            leading: const Icon(Icons.face),
            subtitle:
                const Text('Give coins to winners and send notification.'),
            title: const Text('Claim Winners'),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () {},
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
