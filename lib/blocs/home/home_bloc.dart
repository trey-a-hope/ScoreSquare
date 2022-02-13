import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_version/new_version.dart';
import 'package:score_square/constants/app_themes.dart';
import 'package:score_square/models/bet_model.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/auth_service.dart';
import 'package:score_square/services/bet_service.dart';
import 'package:score_square/services/util_service.dart';
import 'package:score_square/widgets/basic_page.dart';
import 'package:score_square/widgets/bet_view.dart';
import 'package:score_square/widgets/custom_app_drawer.dart';
import 'package:score_square/widgets/list_tiles/user_list_tile.dart';
import '../../service_locator.dart';
import 'package:score_square/blocs/game/game_bloc.dart' as game;

part 'home_event.dart';
part 'home_state.dart';
part 'home_page.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(LoadingState());

      //Fetch user.
      UserModel user = await locator<AuthService>().getCurrentUser();

      //Fetch bets for this user.
      List<BetModel> bets =
          await locator<BetService>().listByUserID(uid: user.uid!);

      //Split bets into open and closed.
      List<BetModel> openBets = [];
      List<BetModel> closedBets = [];

      for (int i = 0; i < bets.length; i++) {
        GameModel game = await bets[i].game();
        if (game.isOpen()) {
          openBets.add(bets[i]);
        } else {
          closedBets.add(bets[i]);
        }
      }

      emit(
        LoadedState(
          user: user,
          openBets: openBets,
          closedBets: closedBets,
        ),
      );
    });
  }
}
