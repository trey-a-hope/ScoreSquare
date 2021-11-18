import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/services/game_service.dart';
import 'package:score_square/widgets/custom_app_drawer.dart';
import 'package:score_square/widgets/custom_button.dart';

import '../../service_locator.dart';

part 'admin_event.dart';
part 'admin_state.dart';
part 'admin_page.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(const LoadedState());
    });
    on<CreateGameEvent>((event, emit) async {
      GameModel game = GameModel(
        awayTeamScore: 101,
        id: null,
        awayTeamID: 1,
        homeTeamID: 2,
        homeTeamScore: 98,
        betPrice: 1.00,
        status: 0,
      );
      locator<GameService>().create(game: game);
    });
  }
}
