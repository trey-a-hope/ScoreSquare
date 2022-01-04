part of 'delete_game_bloc.dart';

class DeleteGamePage extends StatefulWidget {
  const DeleteGamePage({Key? key}) : super(key: key);

  @override
  _DeleteGamePageState createState() => _DeleteGamePageState();
}

class _DeleteGamePageState extends State<DeleteGamePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      child: BlocConsumer<DeleteGameBloc, DeleteGameState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LoadedState) {
            GameModel game = state.game;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [GameListTile(game: game, onTap: () {})],
            );
          }

          return Container();
        },
        listener: (context, state) {
          if (state is LoadedState) {
            if (state.showMessage) {
              locator<ModalService>().showInSnackBar(
                context: context,
                message: 'Game deleted successfully, (refresh page).',
              );
            }
          }
        },
      ),
      title: 'Delete Game',
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      rightIconButton: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          bool? confirm = await locator<ModalService>().showConfirmation(
              context: context,
              title: 'Delete Game',
              message: 'This will delete the game and all of its bets.');

          if (confirm == null || confirm == false) {
            return;
          }

          context.read<DeleteGameBloc>().add(
                DeleteEvent(),
              );
        },
      ),
    );
  }
}
