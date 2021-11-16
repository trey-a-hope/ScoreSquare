import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/models/nba_team_model.dart';
import 'package:score_square/services/game_service.dart';
import 'package:score_square/widgets/custom_app_drawer.dart';
import '../../service_locator.dart';
import '../../constants.dart';

part 'games_event.dart';
part 'games_state.dart';
part 'games_page.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  GamesBloc() : super(GamesInitial()) {
    on<GamesLoadPageEvent>((event, emit) async {
      List<GameModel> games = await locator<GameService>().list();
      emit(GamesLoadedState(games: games));
    });
  }
}
