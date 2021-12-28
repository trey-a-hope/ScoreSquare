part of 'give_coins_bloc.dart';

class GiveCoinsPage extends StatefulWidget {
  const GiveCoinsPage({Key? key}) : super(key: key);

  @override
  _GiveCoinsPageState createState() => _GiveCoinsPageState();
}

class _GiveCoinsPageState extends State<GiveCoinsPage> {
  final TextEditingController _coinsController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Give Coins'),
        centerTitle: true,
      ),
      body: BlocConsumer<GiveCoinsBloc, GiveCoinsState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is LoadedState) {
            UserModel user = state.user;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextHeader(
                  text:
                      '${user.username} has ${user.coins} coins, how many coins do you want to give them?',
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: _coinsController,
                    decoration: const InputDecoration(
                      labelText: 'Coin amount',
                    ),
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
                    int? coins = int.tryParse(_coinsController.text);

                    if (coins == null) return;

                    bool? confirm = await locator<ModalService>()
                        .showConfirmation(
                            context: context,
                            title: 'Send ${user.username} $coins coins?',
                            message: 'Are you sure?');

                    if (confirm == null || confirm == false) {
                      return;
                    }

                    context.read<GiveCoinsBloc>().add(
                          SubmitEvent(
                            coins: coins,
                          ),
                        );
                  },
                  icon: const Icon(Icons.attach_money),
                  label: const Text('Send Coins'),
                ),
              ],
            );
          }

          return Container();
        },
        listener: (context, state) {
          if (state is LoadedState) {
            if (state.snackbarMessage != null) {
              _coinsController.clear();
              locator<ModalService>().showInSnackBar(
                context: context,
                message: state.snackbarMessage!,
              );
            }
          }
        },
      ),
    );
  }
}
