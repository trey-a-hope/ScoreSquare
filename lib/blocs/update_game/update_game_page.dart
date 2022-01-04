part of 'update_game_bloc.dart';

class UpdateGamePage extends StatefulWidget {
  const UpdateGamePage({Key? key}) : super(key: key);

  @override
  _UpdateGamePageState createState() => _UpdateGamePageState();
}

class _UpdateGamePageState extends State<UpdateGamePage> {
  final TextEditingController _homeTeamScoreController =
      TextEditingController();
  final TextEditingController _awayTeamScoreController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      rightIconButton: IconButton(
        icon: const Icon(Icons.check),
        onPressed: () async {
          bool? confirm = await locator<ModalService>().showConfirmation(
              context: context, title: 'Update Game', message: 'Are you sure?');

          if (confirm == null || confirm == false) {
            return;
          }

          context.read<UpdateGameBloc>().add(
                SubmitEvent(
                  homeTeamScore: int.parse(_homeTeamScoreController.text),
                  awayTeamScore: int.parse(_awayTeamScoreController.text),
                ),
              );
        },
      ),
      child: BlocConsumer<UpdateGameBloc, UpdateGameState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LoadedState) {
            GameModel game = state.game;
            bool isOpen = state.isOpen;

            _homeTeamScoreController.text = game.homeTeamScore.toString();
            _awayTeamScoreController.text = game.awayTeamScore.toString();

            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: _homeTeamScoreController,
                          decoration: InputDecoration(
                              labelText: '${game.homeTeam().name} score'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                        ),
                      ),
                    ),
                    const Text('vs.'),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: _awayTeamScoreController,
                          decoration: InputDecoration(
                              labelText: '${game.awayTeam().name} score'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                        ),
                      ),
                    )
                  ],
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        isOpen ? Colors.green : Colors.red),
                  ),
                  onPressed: () async {
                    context.read<UpdateGameBloc>().add(
                          ToggleIsOpenEvent(
                            isOpen: isOpen,
                          ),
                        );
                  },
                  icon: Icon(isOpen ? Icons.timelapse : Icons.check),
                  label: Text('Game ${isOpen ? 'not' : ''} ended'),
                ),
              ],
            );
          }

          return Container();
        },
        listener: (context, state) {
          if (state is LoadedState) {
            if (state.showSnackbarMessage) {
              locator<ModalService>().showInSnackBar(
                context: context,
                message: 'Game updated.',
              );
            }
          }
        },
      ),
      title: 'Update Game',
    );
  }
}
