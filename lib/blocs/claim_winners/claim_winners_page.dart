part of 'claim_winners_bloc.dart';

class ClaimWinnersPage extends StatefulWidget {
  const ClaimWinnersPage({Key? key}) : super(key: key);

  @override
  _ClaimWinnersPageState createState() => _ClaimWinnersPageState();
}

class _ClaimWinnersPageState extends State<ClaimWinnersPage> {
  _ClaimWinnersPageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      title: 'Claim Winners',
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      child: BlocConsumer<ClaimWinnersBloc, ClaimWinnersState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is LoadedState) {
            List<GameModel> games = state.games;

            return games.isEmpty
                ? const Center(
                    child: Text('No games ready to be claimed.'),
                  )
                : ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      GameModel game = games[index];
                      return GameListTile(
                        slidableAction: SlidableAction(
                          onPressed: (_) async {
                            List<UserModel> winners =
                                await locator<GameService>()
                                    .getWinners(game: game);

                            String message = '';

                            if (winners.isEmpty) {
                              message = 'There were no winners.';
                            } else {
                              message += 'The winners were; ';
                              for (int i = 0; i < winners.length; i++) {
                                message += '${winners[i].username},';
                              }
                            }

                            bool? confirm =
                                await locator<ModalService>().showConfirmation(
                              context: context,
                              title: 'Claim Winners?',
                              message: message,
                            );

                            if (confirm == null || confirm == false) {
                              return;
                            }

                            context.read<ClaimWinnersBloc>().add(
                                  ClaimEvent(game: game),
                                );
                          },
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.face,
                          label: 'Claim Winners',
                        ),
                        game: games[index],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (BuildContext context) =>
                                    game_bloc.GameBloc(
                                  gameID: game.id!,
                                )..add(
                                        game_bloc.LoadPageEvent(),
                                      ),
                                child: const game_bloc.GamePage(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
          }

          return Container();
        },
        listener: (context, state) {
          if (state is LoadedState) {
            if (state.showMessage) {
              locator<ModalService>().showInSnackBar(
                context: context,
                message: 'Gamed successfully claimed.',
              );
            }
          }
        },
      ),
    );
  }
}
