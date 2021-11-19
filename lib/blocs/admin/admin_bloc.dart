import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/services/game_service.dart';
import 'package:score_square/widgets/custom_app_drawer.dart';

import '../../service_locator.dart';

part 'admin_event.dart';
part 'admin_page.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  Random random = Random();

  AdminBloc() : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(const LoadedState());
    });
    on<CreateGameEvent>((event, emit) async {
      GameModel game = GameModel(
        id: null,
        awayTeamID: 1 + random.nextInt(30),
        homeTeamID: 1 + random.nextInt(30),
        homeTeamScore: 70 + random.nextInt(30),
        awayTeamScore: 70 + random.nextInt(30),
        betPrice: 1.00,
        status: -1,
        betCount: 0,
      );
      locator<GameService>().create(game: game);
    });
  }
}
