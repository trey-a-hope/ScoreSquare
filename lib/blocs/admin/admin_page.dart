part of 'admin_bloc.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Admin'),
        centerTitle: true,
      ),
      drawer: const CustomAppDrawer(),
      body: BlocConsumer<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is CreateGameState) {
            return SafeArea(
              child: Column(
                children: [
                  const CustomTextHeader(text: 'Create Game'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            // var s = await locator<ModalService>()
                            //     .showSelectNBATeam(context: context);
                            // print(s);
                          },
                          child: Container(
                            color: Colors.greenAccent,
                            height: 100,
                            width: 100,
                            child: const Text('Select Team'),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          bool? confirm =
                              await locator<ModalService>().showConfirmation(
                            context: context,
                            title: 'Create Game',
                            message: 'Are you sure?',
                          );

                          if (confirm == null || !confirm) return;

                          context.read<AdminBloc>().add(
                                const CreateGameEvent(),
                              );
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Save'),
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red,
                          ),
                        ),
                        onPressed: () {
                          context.read<AdminBloc>().add(LoadPageEvent());
                        },
                        icon: const Icon(Icons.cancel),
                        label: const Text('Cancel'),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            );
          }

          if (state is MenuState) {
            return SafeArea(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      context.read<AdminBloc>().add(
                            const GoToCreateGameStateEvent(),
                          );
                    },
                    leading: const Icon(Icons.sports_basketball),
                    subtitle:
                        const Text('Create a new game for users to bet on.'),
                    title: const Text('Create Game'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.face),
                    subtitle: const Text(
                        'Give coins to winners and send notification.'),
                    title: const Text('Claim Winners'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.update),
                    subtitle: const Text(
                        'Modify score, status, and other details about game.'),
                    title: const Text('Update Game'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.attach_money),
                    subtitle: const Text('Add coins to a user account.'),
                    title: const Text('Give Coins'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            );
          }

          return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}
