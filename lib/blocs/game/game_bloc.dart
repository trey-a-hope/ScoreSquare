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
import 'package:score_square/theme.dart';
import 'package:score_square/widgets/basic_page.dart';
import 'package:score_square/widgets/custom_shimmer.dart';
import '../../constants.dart';
import 'package:score_square/blocs/profile/profile_bloc.dart' as profile;

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
            await locator<BetService>().listByGameID(gameID: _game.id!);

        //Fetch current user.
        _currentUser = await locator<AuthService>().getCurrentUser();

        //Fetch current winners.
        List<UserModel> currentWinners =
            await locator<GameService>().getWinners(game: _game);

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
