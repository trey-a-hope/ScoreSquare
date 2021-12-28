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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Create Game'),
        centerTitle: true,
      ),
      body: BlocConsumer<CreateGameBloc, CreateGameState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is LoadedState) {
            NBATeamModel homeTeam = state.homeTeam;
            NBATeamModel awayTeam = state.awayTeam;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Text(homeTeam.name),
                      onTap: () {
                        SelectDialog.showModal<String>(
                          context,
                          label: 'Select Home Team',
                          selectedValue: homeTeam.name,
                          items: nbaTeams
                              .map((nbaTeam) => nbaTeam.fullName())
                              .toList(),
                          onChange: (String selected) {
                            NBATeamModel team = nbaTeams.firstWhere(
                                (nbaTeam) => nbaTeam.name == selected);
                            context.read<CreateGameBloc>().add(
                                  ChangeHomeTeamEvent(team: team),
                                );
                          },
                        );
                      },
                    ),
                    const Text('vs.'),
                    InkWell(
                      child: Text(awayTeam.name),
                      onTap: () {
                        SelectDialog.showModal<String>(
                          context,
                          label: 'Select Away Team',
                          selectedValue: awayTeam.name,
                          items: nbaTeams.map((e) => e.name).toList(),
                          onChange: (String selected) {
                            NBATeamModel team = nbaTeams.firstWhere(
                                (nbaTeam) => nbaTeam.name == selected);
                            context.read<CreateGameBloc>().add(
                                  ChangeAwayTeamEvent(team: team),
                                );
                          },
                        );
                      },
                    ),
                  ],
                ),
                // ElevatedButton.icon(
                //   style: ButtonStyle(
                //     backgroundColor:
                //         MaterialStateProperty.all<Color>(Colors.green),
                //   ),
                //   onPressed: () async {
                //     showDatePicker(
                //       type: DateTimePickerType.dateTime,
                //       context: context,
                //       initialDate: DateTime.now(),
                //       firstDate: DateTime.now(),
                //       lastDate: DateTime.now().add(
                //         const Duration(days: 30),
                //       ),
                //     );
                //   },
                //   icon: const Icon(Icons.save),
                //   label: const Text('Show Date Time Picker'),
                // ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTime,
                    initialValue: '',
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
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
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
                            title: 'Submit Game',
                            message: 'Are you sure?');

                    if (confirm == null || confirm == false) {
                      return;
                    }

                    context.read<CreateGameBloc>().add(
                          SubmitEvent(),
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
                message: 'Game successfully created.',
              );
            }
          }
        },
      ),
    );
  }
}
