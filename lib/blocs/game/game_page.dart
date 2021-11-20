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

  Widget _section(Color color, Widget child) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: color,
      child: Center(child: child),
    );
  }

  LayoutGrid _buildLayoutGrid({required List<BetModel> bets}) {
    List<String> claimedSquares = [];
    List<String> unclaimedSquares = List.from(squares);

    for (BetModel bet in bets) {
      String b = '${bet.homeDigit}${bet.awayDigit}';
      claimedSquares.add(b);
      unclaimedSquares.remove(b);
    }

    return LayoutGrid(
      areas: '''
                    00 01 02 03 04 05 06 07 08 09
                    10 11 12 13 14 15 16 17 18 19
                    20 21 22 23 24 25 26 27 28 29
                    30 31 32 33 34 35 36 37 38 39
                    40 41 42 43 44 45 46 47 48 49
                    50 51 52 53 54 55 56 57 58 59
                    60 61 62 63 64 65 66 67 68 69
                    70 71 72 73 74 75 76 77 78 79
                    80 81 82 83 84 85 86 87 88 89
                    90 91 92 93 94 95 96 97 98 99
                  ''',
      columnSizes: repeat(10, [(screenWidth! / 10).px]),
      rowSizes: repeat(10, [(screenWidth! / 10).px]),
      children: [
        for (String claimedSquare in claimedSquares)
          _section(Colors.yellow, Text(claimedSquare))
              .inGridArea(claimedSquare),
        for (String unclaimedSquare in unclaimedSquares)
          _section(Colors.blue.shade100, Text(unclaimedSquare))
              .inGridArea(unclaimedSquare),
      ],
    );
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
            List<BetModel> bets = state.bets;
            NBATeamModel homeTeam = state.homeTeam;
            NBATeamModel awayTeam = state.awayTeam;

            return Column(
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
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () async {
                    Random random = Random();
                    context.read<GameBloc>().add(
                          CreateBetEvent(
                            awayDigit: random.nextInt(10),
                            homeDigit: random.nextInt(10),
                          ),
                        );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Create Bet'),
                ),
                _buildLayoutGrid(bets: bets),
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
