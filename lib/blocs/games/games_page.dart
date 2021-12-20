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
    return BlocConsumer<GamesBloc, GamesState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is LoadedState) {
          List<GameModel> games = state.games;

          return DefaultTabController(
            length: 4,
            child: Scaffold(
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
                bottom: const TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: Text('Not Started'),
                    ),
                    Tab(
                      child: Text('Active'),
                    ),
                    Tab(
                      child: Text('Ended'),
                    ),
                    Tab(
                      child: Text('Claimed'),
                    ),
                  ],
                ),
              ),
              drawer: const CustomAppDrawer(),
              body: TabBarView(
                children: [
                  //Not started.
                  GamesListView(
                    games: games.where((game) => game.status == -1).toList(),
                  ),
                  //Active
                  GamesListView(
                    games: games.where((game) => game.status == 0).toList(),
                  ),
                  //Ended
                  GamesListView(
                    games: games.where((game) => game.status == 1).toList(),
                  ),
                  //Claimed
                  GamesListView(
                    games: games.where((game) => game.status == 2).toList(),
                  )
                ],
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
