import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/models/notification_model.dart';
import 'package:score_square/services/modal_service.dart';
import 'package:score_square/services/user_service.dart';
import 'package:score_square/widgets/basic_page.dart';
import 'package:score_square/widgets/list_tiles/notification_list_tile.dart';

import '../../service_locator.dart';

part 'notifications_event.dart';
part 'notifications_page.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final String uid;

  late List<NotificationModel> _notifications;

  NotificationsBloc({required this.uid}) : super(InitialState()) {
    on<LoadPageEvent>(
      (event, emit) async {
        emit(LoadingState());

        _notifications =
            await locator<UserService>().listNotifications(uid: uid);

        emit(LoadedState(notifications: _notifications));
      },
    );

    on<MarkAllAsReadEvent>(
      (event, emit) async {
        emit(LoadingState());

        //Mark all as read.
        for (int i = 0; i < _notifications.length; i++) {
          await locator<UserService>().updateNotification(
            uid: uid,
            notificationID: _notifications[i].id!,
            data: {'isRead': true},
          );
        }

        //Reload notifications.
        _notifications =
            await locator<UserService>().listNotifications(uid: uid);

        emit(LoadedState(notifications: _notifications));
      },
    );
  }
}
