part of 'games_bloc.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({Key? key}) : super(key: key);

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  List<bool> isSelected = [
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.sort),
        onPressed: () {
          showModalBottomSheet<void>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            context: context,
            builder: (BuildContext _) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Sort games by...',
                          style: textTheme.headline4,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();

                              context.read<GamesBloc>().add(
                                    const UpdateSortEvent(
                                      sort: 'starts',
                                      descending: false,
                                    ),
                                  );
                            },
                            child: const Text('Start Date'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();

                              context.read<GamesBloc>().add(
                                    const UpdateSortEvent(
                                      sort: 'betCount',
                                      descending: false,
                                    ),
                                  );
                            },
                            child: const Text('Bet Count'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
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
