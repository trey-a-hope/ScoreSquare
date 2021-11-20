part of 'games_bloc.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({Key? key}) : super(key: key);

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Games'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<GamesBloc>().add(LoadPageEvent());
            },
          )
        ],
      ),
      drawer: const CustomAppDrawer(),
      body: BlocConsumer<GamesBloc, GamesState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is LoadedState) {
            List<GameModel> games = state.games;

            return ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                GameModel _game = games[index];

                NBATeamModel homeTeam =
                    nbaTeams.firstWhere((team) => team.id == _game.homeTeamID);
                NBATeamModel awayTeam =
                    nbaTeams.firstWhere((team) => team.id == _game.awayTeamID);

                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (BuildContext context) => game.GameBloc(
                            game: _game,
                            homeTeam: homeTeam,
                            awayTeam: awayTeam,
                          )..add(
                              game.LoadPageEvent(),
                            ),
                          child: const game.GamePage(),
                        ),
                      ),
                    );
                  },
                  title: Text('${homeTeam.name} vs. ${awayTeam.name}'),
                  subtitle: Text(
                      '${_game.homeTeamScore} - ${_game.awayTeamScore}, ${_game.betCount} bets'),
                  trailing: const Icon(Icons.chevron_right),
                );
              },
            );
          }

          return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}
