import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/auth_service.dart';
import 'package:score_square/theme.dart';
import 'package:score_square/widgets/basic_page.dart';
import 'package:score_square/widgets/custom_app_drawer.dart';
import 'package:score_square/widgets/list_tiles/user_list_tile.dart';
import '../../service_locator.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_page.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late UserModel _user;

  HomeBloc() : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(LoadingState());
      _user = await locator<AuthService>().getCurrentUser();
      emit(LoadedState(user: _user));
    });
  }
}
