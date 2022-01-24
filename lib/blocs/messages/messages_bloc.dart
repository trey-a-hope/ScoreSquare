import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/user_service.dart';
import 'package:score_square/widgets/basic_page.dart';
import 'package:score_square/services/util_service.dart';
import 'package:score_square/blocs/message/message_bloc.dart' as message;
import 'package:score_square/widgets/list_tiles/room_list_tile.dart';
import '../../service_locator.dart';

part 'messages_event.dart';
part 'messages_page.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  late UserModel _currentUser;
  late StreamSubscription subscription;

  MessagesBloc({required String uid}) : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(LoadingState());

      _currentUser = await locator<UserService>().retrieveUser(uid: uid);

      //Query conversations table.
      Query query = FirebaseFirestore.instance.collection('rooms');

      //Filter on user ID.
      query = query.where(_currentUser.uid!, isEqualTo: true);

      if ((await query.get()).docs.isEmpty) {
        emit(NoRoomsState());
      } else {
        Stream<QuerySnapshot> snapshots = query.snapshots();

        subscription = snapshots.listen((querySnapshot) {
          add(RoomAddedEvent(querySnapshot: querySnapshot));
        });
      }
    });
    on<RoomAddedEvent>((event, emit) async {
      emit(HasRoomsState(
          querySnapshot: event.querySnapshot, currentUser: _currentUser));
    });
  }
}
