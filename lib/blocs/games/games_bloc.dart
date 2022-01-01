import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/services/game_service.dart';
import 'package:score_square/theme.dart';
import 'package:score_square/widgets/basic_page.dart';
import 'package:score_square/widgets/games_list_view.dart';
import '../../service_locator.dart';

part 'games_event.dart';
part 'games_page.dart';
part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  GamesBloc() : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(LoadingState());
      List<GameModel> games = await locator<GameService>().list();
      emit(LoadedState(games: games));
    });
  }
}
