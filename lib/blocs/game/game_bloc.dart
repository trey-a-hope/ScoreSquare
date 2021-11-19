import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/models/bet_model.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/models/nba_team_model.dart';

part 'game_event.dart';
part 'game_page.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameModel game;
  final NBATeamModel homeTeam;
  final NBATeamModel awayTeam;

  GameBloc({
    required this.game,
    required this.homeTeam,
    required this.awayTeam,
  }) : super(InitialState()) {
    on<LoadPageEvent>((event, emit) {
      //TODO: Fetch bets.
      emit(LoadedState(
        game: game,
        bets: [],
        homeTeam: homeTeam,
        awayTeam: awayTeam,
      ));
    });
  }
}
