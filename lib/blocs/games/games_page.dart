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
    return BasicPage(
      title: 'Games',
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      rightIconButton: IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () {
          context.read<GamesBloc>().add(LoadPageEvent());
        },
      ),
      child: BlocConsumer<GamesBloc, GamesState>(
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
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: Text(
                          'Open',
                          style: textTheme.bodyText2,
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Closed',
                          style: textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        //Not started.
                        GamesListView(
                          games: games.where((game) => game.isOpen()).toList(),
                        ),
                        //Active
                        GamesListView(
                          games: games.where((game) => !game.isOpen()).toList(),
                        ),
                      ],
                    ),
                  )
                ],
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
      ),
    );
  }
}
