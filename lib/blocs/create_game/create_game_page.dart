part of 'create_game_bloc.dart';

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({Key? key}) : super(key: key);

  @override
  _CreateGamePageState createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      child: BlocConsumer<CreateGameBloc, CreateGameState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is LoadedState) {
            NBATeamModel homeTeam = state.homeTeam;
            NBATeamModel awayTeam = state.awayTeam;
            DateTime startDateTime = state.startDateTime;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          homeTeam.color,
                        ),
                      ),
                      onPressed: () async {
                        Route route = MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SelectItemPage(items: nbaTeams, type: 'Team'),
                        );

                        final result = await Navigator.push(context, route);

                        if (result == null) return;

                        final selectedTeam = result as NBATeamModel;

                        context.read<CreateGameBloc>().add(
                              ChangeHomeTeamEvent(team: selectedTeam),
                            );
                      },
                      icon: const Icon(Icons.sports_basketball),
                      label: Text(homeTeam.name),
                    ),
                    const Text('vs.'),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          awayTeam.color,
                        ),
                      ),
                      onPressed: () async {
                        Route route = MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SelectItemPage(items: nbaTeams, type: 'Team'),
                        );

                        final result = await Navigator.push(context, route);

                        if (result == null) return;

                        final selectedTeam = result as NBATeamModel;

                        context.read<CreateGameBloc>().add(
                              ChangeAwayTeamEvent(team: selectedTeam),
                            );
                      },
                      icon: const Icon(Icons.sports_basketball),
                      label: Text(awayTeam.name),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTime,
                    initialValue: startDateTime.toString(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 30),
                    ),
                    dateLabelText: 'Select start date and time.',
                    onChanged: (val) {
                      DateTime dt = DateTime.parse(val);

                      context.read<CreateGameBloc>().add(
                            ChangeStartDateTimeEvent(dt: dt),
                          );
                    },
                    validator: (val) {
                      return null;
                    },
                  ),
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
                message: 'Game successfully created.',
              );
            }
          }
        },
      ),
      title: 'Create Game',
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
              context: context, title: 'Submit Game', message: 'Are you sure?');

          if (confirm == null || confirm == false) {
            return;
          }

          context.read<CreateGameBloc>().add(
                SubmitEvent(),
              );
        },
      ),
    );
  }
}
