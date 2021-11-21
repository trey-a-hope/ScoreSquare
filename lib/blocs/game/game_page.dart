part of 'game_bloc.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final TextStyle _textStyleForDigit = const TextStyle(
    fontSize: 75,
    fontWeight: FontWeight.bold,
    color: Colors.blueAccent,
  );

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

  LayoutGrid _buildLayoutGrid({
    required List<BetModel> bets,
    required String currentBet,
  }) {
    //Create arrays for the squares that are claimed and unclaimed.
    List<String> claimedSquares = [];
    List<String> unclaimedSquares = List.from(squares);

    //Remove the current bet from the unclaimed.
    unclaimedSquares.remove(currentBet);

    //Remove the claimed bets from the unclaimed bets.
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
        for (String claimedSquare in claimedSquares) ...[
          if (claimedSquare == currentBet)
            _section(Colors.yellow, Text(claimedSquare))
                .inGridArea(claimedSquare)
          else
            _section(Colors.blue.shade100, Text(claimedSquare))
                .inGridArea(claimedSquare),
        ],
        for (String unclaimedSquare in unclaimedSquares)
          _section(Colors.blue.shade700, Text(unclaimedSquare))
              .inGridArea(unclaimedSquare),
      ],
    );
  }

  void _showPurchaseMoreCoinsModal({required UserModel currentUser}) async {
    bool? confirm = await locator<ModalService>().showConfirmation(
        context: context,
        title: 'You have ${currentUser.coins} coins.',
        message: 'Would you like to purchase more?');

    if (confirm == null || confirm == false) {
      return;
    }

    locator<ModalService>().showAlert(
        context: context,
        title: 'TODO',
        message: 'Setup [purchase more coins] feature.');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is BetPurchaseSuccessState) {
          BetModel bet = state.bet;
          //TODO: Build bet purchase success view.
          //TODO: Add button to reload the page.
        }

        if (state is LoadedState) {
          GameModel game = state.game;
          List<BetModel> bets = state.bets;
          NBATeamModel homeTeam = state.homeTeam;
          NBATeamModel awayTeam = state.awayTeam;
          UserModel currentUser = state.currentUser;

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text('${homeTeam.name} vs ${awayTeam.name} '),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              // drawer: const CustomAppDrawer(),
              floatingActionButton: FloatingActionButton.extended(
                // isExtended: true,
                label: Text('You have ${currentUser.coins} coins'),
                backgroundColor: currentUser.coins >= game.betPrice
                    ? Colors.green
                    : Colors.red,
                onPressed: () async {
                  _showPurchaseMoreCoinsModal(currentUser: currentUser);
                },
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
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
                              Text('${game.homeTeamScore}'),
                              Text(
                                '${game.homeTeamScore % 10}',
                                style: _textStyleForDigit,
                              )
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
                              Text('${game.awayTeamScore}'),
                              Text(
                                '${game.awayTeamScore % 10}',
                                style: _textStyleForDigit,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          onPressed: () async {
                            if (currentUser.coins >= game.betPrice) {
                              bool? confirm = await locator<ModalService>()
                                  .showConfirmation(
                                      context: context,
                                      title:
                                          'Purchase Bet for ${game.betPrice} coins?',
                                      message:
                                          'Your bet will be placed at random.');

                              if (confirm == null || confirm == false) {
                                return;
                              }

                              Random random = Random();
                              context.read<GameBloc>().add(
                                    PurchaseBetEvent(
                                      awayDigit: random.nextInt(10),
                                      homeDigit: random.nextInt(10),
                                    ),
                                  );
                            } else {
                              _showPurchaseMoreCoinsModal(
                                  currentUser: currentUser);
                            }
                          },
                          icon: const Icon(MdiIcons.currencyUsd),
                          label: Text('Purchase Bet - ${game.betPrice} coins'),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildLayoutGrid(
                        bets: bets,
                        currentBet:
                            '${game.homeTeamScore % 10}${game.awayTeamScore % 10}',
                      ),
                      const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('All bets are placed at random.')),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
              ));
        }

        return Container();
      },
      listener: (context, state) {},
    );
  }
}
