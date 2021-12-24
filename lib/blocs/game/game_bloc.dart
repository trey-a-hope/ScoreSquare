import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:score_square/models/bet_model.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/models/square_model.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/service_locator.dart';
import 'package:score_square/services/auth_service.dart';
import 'package:score_square/services/bet_service.dart';
import 'package:score_square/services/game_service.dart';
import 'package:score_square/services/modal_service.dart';
import 'package:score_square/services/user_service.dart';

import '../../constants.dart';

part 'game_event.dart';
part 'game_page.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final String gameID;

  late UserModel _currentUser;
  late GameModel _game;

  GameBloc({
    required this.gameID,
  }) : super(InitialState()) {
    on<LoadPageEvent>(
      (event, emit) async {
        //Fetch game.
        _game = await locator<GameService>().read(gameID: gameID);

        //Fetch bets.
        List<BetModel> bets =
            await locator<BetService>().list(gameID: _game.id!);

        //Fetch current user.
        _currentUser = await locator<AuthService>().getCurrentUser();

        //Fetch current winners.
        List<UserModel> currentWinners = [];
        for (int i = 0; i < bets.length; i++) {
          //If the user is in the row or the column, (or both, "JACKPOT"), AND this user is not in the list already, add them to the list of winners.
          if ((bets[i].homeDigit == _game.homeTeamScore % 10 ||
                  bets[i].awayDigit == _game.awayTeamScore % 10) &&
              currentWinners.indexWhere(
                      (currentWinner) => currentWinner.uid == bets[i].uid) <
                  0) {
            currentWinners.add(
              await locator<UserService>().retrieveUser(uid: bets[i].uid),
            );
          }
        }

        emit(
          LoadedState(
            game: _game,
            bets: bets,
            currentUser: _currentUser,
            currentWinners: currentWinners,
          ),
        );
      },
    );

    on<PurchaseBetEvent>(
      (event, emit) async {
        try {
          //Create bet.
          BetModel bet = BetModel(
            awayDigit: event.awayDigit,
            homeDigit: event.homeDigit,
            id: null,
            created: DateTime.now(),
            uid: _currentUser.uid!,
            gameID: _game.id!,
          );

          //Add bet to database.
          await locator<BetService>().purchaseBet(
            uid: _currentUser.uid!,
            bet: bet,
            coins: _game.betPrice,
          );

          emit(BetPurchaseSuccessState(bet: bet));
        } catch (e) {
          emit(
            ErrorState(error: e),
          );
        }
      },
    );
  }
}
