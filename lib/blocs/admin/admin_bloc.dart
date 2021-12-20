import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/services/game_service.dart';
import 'package:score_square/services/modal_service.dart';
import 'package:score_square/widgets/custom_app_drawer.dart';
import 'package:score_square/widgets/custom_text_header.dart';

import '../../service_locator.dart';

part 'admin_event.dart';
part 'admin_page.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  Random random = Random();

  AdminBloc() : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(const MenuState());
    });
    on<GoToCreateGameStateEvent>((event, emit) async {
      emit(const CreateGameState());
    });
    on<CreateGameEvent>((event, emit) async {
      try {
        GameModel game = GameModel(
          id: null,
          awayTeamID: 1 + random.nextInt(30),
          homeTeamID: 1 + random.nextInt(30),
          homeTeamScore: 70 + random.nextInt(30),
          awayTeamScore: 70 + random.nextInt(30),
          betPrice: 3,
          status: random.nextInt(3) - 1,
          betCount: 0,
          starts: DateTime.now(),
        );

        locator<GameService>().create(game: game);

        emit(const MenuState());
      } catch (e) {
        emit(ErrorState(error: e));
      }
    });
  }
}
