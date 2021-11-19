part of 'game_bloc.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Game'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      // drawer: const CustomAppDrawer(),
      body: BlocConsumer<GameBloc, GameState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is LoadedState) {
            GameModel game = state.game;
            NBATeamModel homeTeam = state.homeTeam;
            NBATeamModel awayTeam = state.awayTeam;

            return ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: homeTeam.imgUrl,
                          height: 100,
                        ),
                        Text(homeTeam.name),
                        Text('${game.homeTeamScore}')
                      ],
                    ),
                    const Text('vs.'),
                    Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: awayTeam.imgUrl,
                          height: 100,
                        ),
                        Text(awayTeam.name),
                        Text('${game.awayTeamScore}')
                      ],
                    ),
                  ],
                )
              ],
            );
          }

          return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}
