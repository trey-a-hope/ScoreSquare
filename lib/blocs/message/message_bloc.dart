import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:score_square/constants.dart';
import 'package:score_square/models/message_model.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/auth_service.dart';
import 'package:score_square/services/fcm_notification_service.dart';
import 'package:score_square/theme.dart';
import '../../service_locator.dart';

part 'message_event.dart';
part 'message_state.dart';
part 'message_page.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  late StreamSubscription subscription;
  late UserModel _currentUser;
  late DocumentReference roomDocRef;

  final CollectionReference _roomsDB =
      FirebaseFirestore.instance.collection('rooms');

  DocumentReference? newMessageDocRef;

  MessageBloc({
    required UserModel otherUser,
  }) : super(MessageInitial()) {
    on<LoadPageEvent>(
      (event, emit) async {
        emit(LoadingState());
        //Fetch current user.
        _currentUser = await locator<AuthService>().getCurrentUser();

        Query query = _roomsDB;

        //Find room by filtering on both user IDs being true.
        query = query.where(_currentUser.uid!, isEqualTo: true);
        query = query.where(otherUser.uid!, isEqualTo: true);

        //Extract room docs from query.
        List<DocumentSnapshot> docs = (await query.get()).docs;

        // Create a new room document if one does not already exist.
        if (docs.isEmpty) {
          roomDocRef = _roomsDB.doc();
          roomDocRef.set({
            'id': roomDocRef.id,
            _currentUser.uid!: true,
            otherUser.uid!: true,
            'users': [_currentUser.uid, otherUser.uid],
            'time': DateTime.now(),
            'lastMessage': ''
          });
        } else {
          roomDocRef = docs.first.reference;
        }

        //Set read property to true for the current user.
        roomDocRef.update({
          '${_currentUser.chatUser().id}_read': true,
          '${otherUser.chatUser().id}_read': false
        });

        Query messagesQuery = roomDocRef.collection('messages');

        if ((await messagesQuery.get()).docs.isEmpty) {
          DateTime now = DateTime.now();

          //DocumentReference
          newMessageDocRef = roomDocRef.collection('messages').doc(
                now.millisecondsSinceEpoch.toString(),
              );
        }

        if ((await messagesQuery.get()).docs.isEmpty) {
          emit(
            LoadedState(
              receiver: otherUser,
              sender: _currentUser,
              roomDocRef: roomDocRef,
              messages: const [],
            ),
          );
        } else {
          Stream<QuerySnapshot> snapshots = messagesQuery.snapshots();
          subscription = snapshots.listen(
            (querySnapshot) {
              add(
                MessageAddedEvent(querySnapshot: querySnapshot),
              );
            },
          );
        }
      },
    );
    on<MessageAddedEvent>((event, emit) async {
      List<DocumentSnapshot> docs = event.querySnapshot.docs;

      //Create message models from docs.
      List<MessageModel> messages = [];
      for (int i = 0; i < docs.length; i++) {
        MessageModel message = MessageModel.fromDoc(data: docs[i]);

        if (message.uid == _currentUser.uid) {
          message.user = _currentUser;
        } else {
          message.user = otherUser;
        }

        messages.add(message);
      }

      //Sort messages by most recent.
      messages.sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );

      emit(
        LoadedState(
          receiver: otherUser,
          sender: _currentUser,
          roomDocRef: roomDocRef,
          messages: messages,
        ),
      );
    });

    on<SendMessageEvent>(
      (event, emit) async {
        try {
          ChatMessage chatMessage = event.message;
          FirebaseFirestore db = FirebaseFirestore.instance;
          WriteBatch batch = db.batch();

          DateTime now = DateTime.now();

          batch.update(roomDocRef, {
            '${_currentUser.chatUser().id}_read': true,
            '${otherUser.chatUser().id}_read': false,
            'lastMessage': chatMessage.text,
            'time': now,
          });

          // DocumentReference
          newMessageDocRef = roomDocRef.collection('messages').doc(
                now.millisecondsSinceEpoch.toString(),
              );

          //Create message model.
          MessageModel message = MessageModel(
            uid: _currentUser.uid!,
            createdAt: now,
            text: chatMessage.text,
          );

          batch.set(
            newMessageDocRef!,
            message.toMap(),
          );

          await batch.commit();

          //Send notification to user.
          await locator<FCMNotificationService>().sendNotificationToUser(
            fcmToken: otherUser.fcmToken!,
            title: 'New Message From ${_currentUser.username}',
            body: message.text,
          );

          //Perform new query on on message that was added.
          Query messagesQuery = roomDocRef.collection('messages');

          if ((await messagesQuery.get()).docs.isEmpty) {
            DateTime now = DateTime.now();

            //DocumentReference
            newMessageDocRef = roomDocRef.collection('messages').doc(
                  now.millisecondsSinceEpoch.toString(),
                );
          }

          Stream<QuerySnapshot> snapshots = messagesQuery.snapshots();
          subscription = snapshots.listen(
            (querySnapshot) {
              add(
                MessageAddedEvent(querySnapshot: querySnapshot),
              );
            },
          );
        } catch (error) {
          emit(ErrorState(error: error));
        }
      },
    );
  }
}
