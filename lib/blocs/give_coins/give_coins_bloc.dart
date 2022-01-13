import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/models/notification_model.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/fcm_notification_service.dart';
import 'package:score_square/services/modal_service.dart';
import 'package:score_square/services/user_service.dart';
import 'package:score_square/theme.dart';
import 'package:score_square/widgets/basic_page.dart';

import '../../service_locator.dart';

part 'give_coins_event.dart';
part 'give_coins_page.dart';
part 'give_coins_state.dart';

class GiveCoinsBloc extends Bloc<GiveCoinsEvent, GiveCoinsState> {
  late UserModel _user;

  GiveCoinsBloc({required String uid}) : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(LoadingState());

      _user = await locator<UserService>().retrieveUser(uid: uid);

      emit(
        LoadedState(user: _user),
      );
    });
    on<SubmitEvent>((event, emit) async {
      emit(LoadingState());

      int coins = event.coins;

      //Send coins to users account.
      await locator<UserService>().updateUser(
        uid: _user.uid!,
        data: {
          'coins': FieldValue.increment(coins),
        },
      );

      //Send notification to user.
      if (_user.fcmToken != null) {
        const String title = 'YOU JUST GOT SOME COINS';
        final String message = '$coins to be exact.';

        await locator<FCMNotificationService>().sendNotificationToUser(
          fcmToken: _user.fcmToken!,
          title: title,
          body: message,
        );

        //Add notification to database.
        await locator<UserService>().createNotification(
          uid: _user.uid!,
          notification: NotificationModel(
            title: title,
            message: message,
            isRead: false,
            created: DateTime.now(),
          ),
        );
      }

      //Fetch updated user.
      _user = await locator<UserService>().retrieveUser(uid: uid);

      emit(
        LoadedState(user: _user, snackbarMessage: 'Coins given successfully.'),
      );
    });
  }
}
