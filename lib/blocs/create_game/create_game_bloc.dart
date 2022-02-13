import 'package:date_time_picker/date_time_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/constants/globals.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/models/nba_team_model.dart';
import 'package:score_square/pages/select_item_page.dart';
import 'package:score_square/services/game_service.dart';
import 'package:score_square/services/modal_service.dart';
import 'package:score_square/widgets/basic_page.dart';
import '../../service_locator.dart';

part 'create_game_event.dart';
part 'create_game_state.dart';
part 'create_game_page.dart';

class CreateGameBloc extends Bloc<CreateGameEvent, CreateGameState> {
  NBATeamModel _homeTeam = nbaTeams[0];
  NBATeamModel _awayTeam = nbaTeams[29];
  DateTime _startDateTime = DateTime.now();

  CreateGameBloc() : super(InitialState()) {
    on<LoadPageEvent>((event, emit) {
      emit(
        LoadedState(
          homeTeam: _homeTeam,
          awayTeam: _awayTeam,
          showSnackbarMessage: false,
          startDateTime: _startDateTime,
        ),
      );
    });

    on<ChangeHomeTeamEvent>((event, emit) {
      _homeTeam = event.team;
      emit(
        LoadedState(
          homeTeam: _homeTeam,
          awayTeam: _awayTeam,
          showSnackbarMessage: false,
          startDateTime: _startDateTime,
        ),
      );
    });

    on<ChangeAwayTeamEvent>((event, emit) {
      _awayTeam = event.team;
      emit(
        LoadedState(
          homeTeam: _homeTeam,
          awayTeam: _awayTeam,
          showSnackbarMessage: false,
          startDateTime: _startDateTime,
        ),
      );
    });

    on<ChangeStartDateTimeEvent>((event, emit) {
      _startDateTime = event.dt;
      emit(
        LoadedState(
          homeTeam: _homeTeam,
          awayTeam: _awayTeam,
          showSnackbarMessage: false,
          startDateTime: _startDateTime,
        ),
      );
    });

    on<SubmitEvent>((event, emit) async {
      emit(LoadingState());

      GameModel game = GameModel(
        awayTeamID: _awayTeam.id,
        awayTeamScore: 0,
        betPrice: 3,
        homeTeamID: _homeTeam.id,
        homeTeamScore: 0,
        id: null,
        betCount: 0,
        starts: _startDateTime,
        ends: null,
        modified: DateTime.now(),
        created: DateTime.now(),
        claimed: false,
      );

      await locator<GameService>().create(game: game);

      emit(
        LoadedState(
          homeTeam: _homeTeam,
          awayTeam: _awayTeam,
          showSnackbarMessage: true,
          startDateTime: _startDateTime,
        ),
      );
    });
  }
}
