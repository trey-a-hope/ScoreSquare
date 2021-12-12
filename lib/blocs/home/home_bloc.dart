import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:score_square/constants.dart';
import 'package:score_square/service_locator.dart';
import 'package:score_square/services/modal_service.dart';
import 'package:score_square/widgets/custom_app_drawer.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_page.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(LoadedState()) {
    on<LoadPageEvent>((event, emit) {});
  }
}
