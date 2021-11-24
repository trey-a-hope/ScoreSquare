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

  Widget _section({
    required Color color,
    required String number,
    required UserModel? user,
  }) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: color,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (user != null) ...[
          CachedNetworkImage(
            imageUrl: user.imgUrl == null ? dummyProfileImageUrl : user.imgUrl!,
            imageBuilder: (context, imageProvider) => GFAvatar(
              radius: 15,
              backgroundImage: imageProvider,
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ],
        if (user == null) ...[
          Text(number),
        ]
      ]),
    );
  }

  Future<LayoutGrid> _buildLayoutGrid({
    required List<BetModel> bets,
    required String currentBet,
  }) async {
    List<SquareModel> claimedSquares = [];
    List<SquareModel> unclaimedSquares = List.from(squares)
        .map((square) => SquareModel(user: null, number: square))
        .toList();

    //Remove the claimed bets from the unclaimed bets.
    for (BetModel bet in bets) {
      String curBet = '${bet.homeDigit}${bet.awayDigit}';

      //Fetch the user for this bet.
      UserModel user = await locator<UserService>().retrieveUser(uid: bet.uid);

      //Add the user and the bet to the claimed square.
      claimedSquares.add(SquareModel(user: user, number: curBet));

      //Remove the unclaimed square since it is claimed.
      unclaimedSquares.removeWhere((square) => square.number == curBet);
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
        for (SquareModel claimedSquare in claimedSquares) ...[
          //If a user has claimed the current bet...
          if (claimedSquare.number == currentBet)
            _section(
              color: Colors.yellow,
              user: claimedSquare.user,
              number: claimedSquare.number,
            ).inGridArea(claimedSquare.number)
          //If a user is in the same row or column  as the current bet...
          else if (claimedSquare.number[0] == currentBet[0] ||
              claimedSquare.number[1] == currentBet[1])
            _section(
              color: Colors.green.shade500,
              user: claimedSquare.user,
              number: claimedSquare.number,
            ).inGridArea(claimedSquare.number)
          //Otherwise just display the number.
          else
            _section(
              color: Colors.greenAccent,
              user: claimedSquare.user,
              number: claimedSquare.number,
            ).inGridArea(claimedSquare.number),
        ],
        for (SquareModel unclaimedSquare in unclaimedSquares) ...[
          if (unclaimedSquare.number == currentBet)
            _section(
              color: Colors.green.shade900,
              user: null,
              number: unclaimedSquare.number,
            ).inGridArea(unclaimedSquare.number)
          else if (unclaimedSquare.number[0] == currentBet[0] ||
              unclaimedSquare.number[1] == currentBet[1])
            _section(
              color: Colors.green.shade500,
              user: unclaimedSquare.user,
              number: unclaimedSquare.number,
            ).inGridArea(unclaimedSquare.number)
          else
            _section(
              color: Colors.greenAccent,
              user: null,
              number: unclaimedSquare.number,
            ).inGridArea(unclaimedSquare.number)
        ],
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
          return Scaffold(
            body: Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You have purchased a bet for'),
                    Text(
                      '${bet.homeDigit}${bet.awayDigit}',
                      style: _textStyleForDigit,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'If the home team scores a digit ending in ${bet.homeDigit}, or the away team scores a digit ending in ${bet.awayDigit}, you win!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton.icon(
                      label: const Text('Done'),
                      icon: const Icon(Icons.done),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        context.read<GameBloc>().add(
                              LoadPageEvent(),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is LoadedState) {
          GameModel game = state.game;
          List<BetModel> bets = state.bets;
          NBATeamModel homeTeam = state.homeTeam;
          NBATeamModel awayTeam = state.awayTeam;
          UserModel currentUser = state.currentUser;
          List<UserModel> currentWinners = state.currentWinners;

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text('${homeTeam.name} vs ${awayTeam.name} '),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      context.read<GameBloc>().add(LoadPageEvent());
                    },
                  )
                ],
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
                      Text('Winning Pot: ${bets.length * game.betPrice} coins'),
                      Text('Total Bets:  ${bets.length}/$maxBetsPerGame'),
                      if (bets.length < maxBetsPerGame) ...[
                        SizedBox(
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
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

                                //TODO: Ensure the bet is random...

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
                            label:
                                Text('Purchase Bet - ${game.betPrice} coins'),
                          ),
                        ),
                      ],
                      const SizedBox(
                        height: 30,
                      ),
                      FutureBuilder(
                        future: _buildLayoutGrid(
                          bets: bets,
                          currentBet:
                              '${game.homeTeamScore % 10}${game.awayTeamScore % 10}',
                        ),
                        builder: (BuildContext context,
                            AsyncSnapshot<LayoutGrid> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: Text(
                                    'Loading current bets for this game...'));
                          } else {
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              return snapshot
                                  .data!; // snapshot.data  :- get your object which is pass from your downloadData() function

                            }
                          }
                        },
                      ),
                      if (currentWinners.isNotEmpty) ...[
                        Text('Current Winners - ${currentWinners.length}'),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: currentWinners.length,
                            itemBuilder: (
                              context,
                              index,
                            ) {
                              return ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl: currentWinners[index].imgUrl == null
                                      ? dummyProfileImageUrl
                                      : currentWinners[index].imgUrl!,
                                  imageBuilder: (context, imageProvider) =>
                                      GFAvatar(
                                    radius: 15,
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                title: Text(currentWinners[index].username),
                              );
                            })
                      ],
                      const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('All bets are placed at random.')),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
              ));
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
