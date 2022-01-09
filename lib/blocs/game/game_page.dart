part of 'game_bloc.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          UserCircleAvatar(
            uid: user.uid!,
            radius: 15,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (BuildContext context) =>
                        profile.ProfileBloc(uid: user.uid!)
                          ..add(
                            profile.LoadPageEvent(),
                          ),
                    child: const profile.ProfilePage(),
                  ),
                ),
              );
            },
          ),
        ],
        if (user == null) ...[
          Text(
            number,
            style: textTheme.headline6,
          ),
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
      columnSizes: repeat(10, [(MediaQuery.of(context).size.width / 10).px]),
      rowSizes: repeat(10, [(MediaQuery.of(context).size.width / 10).px]),
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
              color: Colors.grey.shade300,
              user: claimedSquare.user,
              number: claimedSquare.number,
            ).inGridArea(claimedSquare.number)
          //Otherwise just display the number.
          else
            _section(
              color: Colors.white,
              user: claimedSquare.user,
              number: claimedSquare.number,
            ).inGridArea(claimedSquare.number),
        ],
        for (SquareModel unclaimedSquare in unclaimedSquares) ...[
          if (unclaimedSquare.number == currentBet)
            _section(
              color: Colors.grey.shade500,
              user: null,
              number: unclaimedSquare.number,
            ).inGridArea(unclaimedSquare.number)
          else if (unclaimedSquare.number[0] == currentBet[0] ||
              unclaimedSquare.number[1] == currentBet[1])
            _section(
              color: Colors.grey.shade300,
              user: unclaimedSquare.user,
              number: unclaimedSquare.number,
            ).inGridArea(unclaimedSquare.number)
          else
            _section(
              color: Colors.white,
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

  //Return true if the list of bets do no contain the digit combination.
  bool _betIsUnique(
      {required List<BetModel> bets,
      required int homeDigit,
      required int awayDigit}) {
    for (int i = 0; i < bets.length; i++) {
      if (bets[i].homeDigit == homeDigit && bets[i].awayDigit == awayDigit) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
        scaffoldKey: _scaffoldKey,
        leftIconButton: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        rightIconButton: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            context.read<GameBloc>().add(
                  LoadPageEvent(),
                );
          },
        ),
        child: BlocConsumer<GameBloc, GameState>(
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
                                MaterialStateProperty.all<Color>(colorDarkBlue),
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
              UserModel currentUser = state.currentUser;
              List<UserModel> currentWinners = state.currentWinners;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: game.homeTeam().imgUrl,
                              height: 100,
                            ),
                            Text(
                              game.homeTeam().name,
                              style: textTheme.headline3,
                            ),
                            Text(
                              '${game.homeTeamScore}',
                              style: textTheme.headline4,
                            ),
                            Text(
                              '${game.homeTeamScore % 10}',
                              style: _textStyleForDigit,
                            )
                          ],
                        ),
                        Text(
                          'vs.',
                          style: textTheme.headline3,
                        ),
                        Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: game.awayTeam().imgUrl,
                              height: 100,
                            ),
                            Text(
                              game.awayTeam().name,
                              style: textTheme.headline3,
                            ),
                            Text(
                              '${game.awayTeamScore}',
                              style: textTheme.headline4,
                            ),
                            Text(
                              '${game.awayTeamScore % 10}',
                              style: _textStyleForDigit,
                            )
                          ],
                        ),
                      ],
                    ),

                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: Text(
                        'Winning Pot',
                        style: textTheme.headline3,
                      ),
                      subtitle: Text(
                        '${bets.length * game.betPrice} coins',
                        style: textTheme.headline4,
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(
                        'Total Bets',
                        style: textTheme.headline3,
                      ),
                      subtitle: Text(
                        '${bets.length} / $maxBetsPerGame',
                        style: textTheme.headline4,
                      ),
                    ),
                    const Divider(),
                    //If the game has not ended and  the max bet count has not been reached...
                    if (bets.length < maxBetsPerGame && game.isOpen()) ...[
                      SizedBox(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              colorDarkBlue,
                            ),
                          ),
                          onPressed: () async {
                            if (currentUser.coins >= game.betPrice) {
                              //Prompt user for purchasing this bet.
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

                              //Create random bet.
                              Random random = Random();

                              late int awayDigit;
                              late int homeDigit;

                              //Generate new random bets until a unique one is found.
                              do {
                                awayDigit = random.nextInt(10);
                                homeDigit = random.nextInt(10);
                              } while (!_betIsUnique(
                                  bets: bets,
                                  awayDigit: awayDigit,
                                  homeDigit: homeDigit));

                              context.read<GameBloc>().add(
                                    PurchaseBetEvent(
                                      awayDigit: awayDigit,
                                      homeDigit: homeDigit,
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
                          return Column(
                            children: [
                              const Text('Loading bets for this game...'),
                              CustomShimmer(
                                child: LayoutGrid(
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
                                  columnSizes: repeat(10, [
                                    (MediaQuery.of(context).size.width / 10).px
                                  ]),
                                  rowSizes: repeat(10, [
                                    (MediaQuery.of(context).size.width / 10).px
                                  ]),
                                  children: [
                                    for (int i = 0; i < 100; i++) ...[
                                      _section(
                                        color: Colors.grey.shade300,
                                        user: null,
                                        number: '$i',
                                      ).inGridArea('$i')
                                    ]
                                  ],
                                ),
                              )
                            ],
                          );
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
                      Text(
                          '${game.isOpen() ? 'Current' : 'Final'} Winners - ${currentWinners.length}'),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 90,
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: currentWinners.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    UserCircleAvatar(
                                      uid: currentWinners[index].uid!,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (BuildContext context) =>
                                                  profile.ProfileBloc(
                                                      uid: currentWinners[index]
                                                          .uid!)
                                                    ..add(
                                                      profile.LoadPageEvent(),
                                                    ),
                                              child:
                                                  const profile.ProfilePage(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Text(currentWinners[index].username),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('All bets are placed at random.'),
                    ),
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
        title: 'Game');
  }
}
