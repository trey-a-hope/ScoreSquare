import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/services/game_service.dart';
import 'package:score_square/constants/app_themes.dart';
import 'package:score_square/widgets/basic_page.dart';
import 'package:score_square/widgets/games_list_view.dart';
import '../../service_locator.dart';

part 'games_event.dart';
part 'games_page.dart';
part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  late List<GameModel> _games;
  GamesBloc() : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(LoadingState());
      _games = await locator<GameService>().list();
      emit(LoadedState(games: _games));
    });
    on<UpdateSortEvent>((event, emit) async {
      emit(LoadingState());

      //Update sort order.
      switch (event.sort) {
        case 'starts':
          if (event.descending) {
            _games.sort((a, b) => b.starts.compareTo(a.starts));
          } else {
            _games.sort((a, b) => a.starts.compareTo(b.starts));
          }
          break;
        case 'betCount':
          if (event.descending) {
            _games.sort((a, b) => a.betCount.compareTo(b.betCount));
          } else {
            _games.sort((a, b) => b.betCount.compareTo(a.betCount));
          }
          break;
        default:
          break;
      }

      emit(LoadedState(games: _games));
    });
  }
}
