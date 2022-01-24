import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:score_square/blocs/message/message_bloc.dart';
import 'package:score_square/models/room_model.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/user_service.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../service_locator.dart';

// A list tile that displays information about a user's conversation.
class RoomListTile extends StatefulWidget {
  const RoomListTile(
      {Key? key, required this.roomDoc, required this.currentUser})
      : super(key: key);
  final DocumentSnapshot roomDoc;
  final UserModel currentUser;

  @override
  _RoomListTileState createState() => _RoomListTileState();
}

class _RoomListTileState extends State<RoomListTile> {
  @override
  void initState() {
    super.initState();
  }

  Future<RoomModel> createRoom() async {
    dynamic userIDs = widget.roomDoc.get('users');

    //Determine the user you are speaking with.
    UserModel oppositeUser = widget.currentUser.uid == userIDs[0]
        ? await locator<UserService>().retrieveUser(uid: userIDs[1])
        : await locator<UserService>().retrieveUser(uid: userIDs[0]);

    //Create conversation item.
    return RoomModel(
      title: oppositeUser.username,
      lastMessage: widget.roomDoc.get('lastMessage'),
      imageUrl: oppositeUser.imgUrl!,
      sender: widget.currentUser,
      receiver: oppositeUser,
      reference: widget.roomDoc.reference,
      time: widget.roomDoc.get('time').toDate(),
      read: widget.roomDoc.get('${widget.currentUser.uid}_read'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: createRoom(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            RoomModel room = snapshot.data;

            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Route route = MaterialPageRoute(
                      builder: (BuildContext context) => BlocProvider(
                        create: (BuildContext context) => MessageBloc(
                          otherUser: room.receiver!,
                        )..add(
                            LoadPageEvent(),
                          ),
                        child: const MessagePage(),
                      ),
                    );

                    Navigator.push(
                      context,
                      route,
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple,
                    backgroundImage: NetworkImage(room.receiver!.imgUrl!),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                  title: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          room.read!
                              ? Container()
                              : const Icon(
                                  MdiIcons.circle,
                                  size: 10,
                                  color: Colors.lightBlue,
                                ),
                          room.read!
                              ? Container()
                              : const SizedBox(
                                  width: 10,
                                ),
                          Text(
                            room.title!,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: room.read!
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${room.lastMessage == '' ? '"No Last Message"' : room.lastMessage}',
                        maxLines: 1,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Sent ${timeago.format(room.time!)}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                ),
                const Divider()
              ],
            );
        }
      },
    );
  }
}
