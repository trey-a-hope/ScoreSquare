import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:score_square/models/bet_model.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/models/nba_team_model.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/service_locator.dart';
import 'package:score_square/services/auth_service.dart';
import 'package:score_square/services/bet_service.dart';

import '../../constants.dart';

part 'game_event.dart';
part 'game_page.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameModel game;
  final NBATeamModel homeTeam;
  final NBATeamModel awayTeam;

  late UserModel _currentUser;

  GameBloc({
    required this.game,
    required this.homeTeam,
    required this.awayTeam,
  }) : super(InitialState()) {
    on<LoadPageEvent>(
      (event, emit) async {
        List<BetModel> bets =
            await locator<BetService>().list(gameID: game.id!);
        _currentUser = await locator<AuthService>().getCurrentUser();

        emit(
          LoadedState(
            game: game,
            bets: bets,
            homeTeam: homeTeam,
            awayTeam: awayTeam,
          ),
        );
      },
    );

    on<CreateBetEvent>(
      (event, emit) async {
        try {
          //Create bet.
          BetModel bet = BetModel(
            awayDigit: event.awayDigit,
            homeDigit: event.homeDigit,
            id: null,
            created: DateTime.now(),
            uid: _currentUser.uid!,
            gameID: game.id!,
          );

          //Add bet to database.
          await locator<BetService>().create(bet: bet);

          //Fetch bets with newly added bet.
          List<BetModel> bets =
              await locator<BetService>().list(gameID: game.id!);

          emit(
            LoadedState(
              game: game,
              bets: bets,
              homeTeam: homeTeam,
              awayTeam: awayTeam,
            ),
          );
        } catch (e) {
          emit(
            ErrorState(error: e),
          );
        }
      },
    );
  }
}
