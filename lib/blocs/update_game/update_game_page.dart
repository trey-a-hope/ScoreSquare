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
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Update Game'),
        centerTitle: true,
      ),
      body: BlocConsumer<UpdateGameBloc, UpdateGameState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is LoadedState) {
            GameModel game = state.game;

            _homeTeamScoreController.text = game.homeTeamScore.toString();
            _awayTeamScoreController.text = game.awayTeamScore.toString();
            _statusController.text = game.status.toString();

            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          controller: _homeTeamScoreController,
                          decoration: const InputDecoration(
                              labelText: 'Home team score.'),
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
                          decoration: const InputDecoration(
                              labelText: 'Away team score.'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: _statusController,
                    decoration: const InputDecoration(
                        labelText: 'Status, (-1, 0, 1, 2)'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () async {
                    bool? confirm = await locator<ModalService>()
                        .showConfirmation(
                            context: context,
                            title: 'Update Game',
                            message: 'Are you sure?');

                    if (confirm == null || confirm == false) {
                      return;
                    }

                    context.read<UpdateGameBloc>().add(
                          SubmitEvent(
                            homeTeamScore:
                                int.parse(_homeTeamScoreController.text),
                            awayTeamScore:
                                int.parse(_awayTeamScoreController.text),
                            status: int.parse(_statusController.text),
                          ),
                        );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
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
    );
  }
}
