part of 'messages_bloc.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      title: 'Messages',
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      rightIconButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () async {
          UserModel? user =
              await locator<UtilService>().searchForUser(context: context);

          if (user == null) {
            return;
          }

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (BuildContext context) =>
                    message.MessageBloc(otherUser: user)
                      ..add(
                        message.LoadPageEvent(),
                      ),
                child: const message.MessagePage(),
              ),
            ),
          );
        },
      ),
      child: BlocConsumer<MessagesBloc, MessagesState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is NoRoomsState) {
            return const Center(child: Text('Sorry, no messages yet.'));
          }

          if (state is HasRoomsState) {
            List<DocumentSnapshot> docs = state.querySnapshot.docs;
            UserModel currentUser = state.currentUser;

            //Sort docs by time.
            docs.sort(
              (a, b) => b['time'].toDate().compareTo(
                    a['time'].toDate(),
                  ),
            );

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot roomDoc = docs[index];
                return RoomListTile(
                  roomDoc: roomDoc,
                  currentUser: currentUser,
                );
              },
            );
          }

          return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}
