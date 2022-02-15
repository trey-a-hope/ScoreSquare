part of 'message_bloc.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);
  @override
  MessagePageState createState() => MessagePageState();
}

class MessagePageState extends State<MessagePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<ChatMessage> _messages = [];
  List<ChatMessage> _m = [];

  int _i = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (_i < 6) {
        setState(() {
          _messages = [..._messages, _m[_i]];
        });
        _i++;
      }
      // Timer(Duration(milliseconds: 300), () {
      //   _chatViewKey.currentState.scrollController
      //     ..animateTo(
      //       _chatViewKey.currentState.scrollController.position.maxScrollExtent,
      //       curve: Curves.easeOut,
      //       duration: const Duration(milliseconds: 300),
      //     );
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //Delete room if there are no messages.
        if ((await context
                .read<MessageBloc>()
                .roomDocRef
                .collection('messages')
                .get())
            .docs
            .isEmpty) {
          await context.read<MessageBloc>().roomDocRef.delete();
        }
        return true;
      },
      child: BlocBuilder<MessageBloc, MessageState>(
        builder: (BuildContext context, MessageState state) {
          if (state is LoadingState) {
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(''),
                    CircleAvatar(
                      backgroundImage: NetworkImage(dummyProfileImageUrl),
                    )
                  ],
                ),
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          if (state is LoadedState) {
            List<MessageModel> messages = state.messages;
            UserModel receiver = state.receiver;

            //Convert messages to chat messages.
            List<ChatMessage> chatMessages = messages
                .map(
                  (message) => ChatMessage(
                    user: message.user!.chatUser(),
                    createdAt: message.createdAt,
                    text: message.text,
                  ),
                )
                .toList();

            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(receiver.username),
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(receiver.imgUrl ?? dummyProfileImageUrl),
                    )
                  ],
                ),
              ),
              body: SafeArea(
                child: DashChat(
                  inputOptions: InputOptions(
                    sendOnEnter: true,
                    alwaysShowSend: true,
                    inputTextStyle: AppThemes.textTheme.headline5,
                  ),
                  messageListOptions: MessageListOptions(
                    showDateSeparator: true,
                    dateSeparatorFormat: DateFormat('E h:mm aa'),
                  ),
                  messageOptions: const MessageOptions(
                    showCurrentUserAvatar: true,
                    showOtherUsersAvatar: true,
                    textColor: Colors.black,
                    currentUserTextColor: Colors.black,
                  ),
                  currentUser: state.sender.chatUser(),
                  onSend: (ChatMessage message) {
                    if (message.text == '') {
                      return;
                    }
                    context.read<MessageBloc>().add(
                          SendMessageEvent(message: message),
                        );
                  },
                  messages: chatMessages,
                ),
              ),
            );
          }

          if (state is ErrorState) {
            return ErrorView(
              error: state.error.toString(),
            );
          }

          return Container();
        },
      ),
    );
  }
}
