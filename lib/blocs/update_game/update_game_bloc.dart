import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/models/game_model.dart';
import 'package:score_square/services/game_service.dart';
import 'package:score_square/services/modal_service.dart';
import '../../service_locator.dart';

part 'update_game_event.dart';
part 'update_game_state.dart';
part 'update_game_page.dart';

class UpdateGameBloc extends Bloc<UpdateGameEvent, UpdateGameState> {
  final String gameID;
  UpdateGameBloc({required this.gameID}) : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      try {
        //Fetch the game based on ID.
        GameModel game = await locator<GameService>().read(gameID: gameID);

        emit(LoadedState(game: game, showSnackbarMessage: false));
      } catch (error) {
        emit(
          ErrorState(error: error),
        );
      }
    });
    on<SubmitEvent>((event, emit) async {
      try {
        //Update the score of the game.
        await locator<GameService>().update(gameID: gameID, data: {
          'homeTeamScore': event.homeTeamScore,
          'awayTeamScore': event.awayTeamScore,
          'status': event.status,
        });

        GameModel game = await locator<GameService>().read(gameID: gameID);

        emit(LoadedState(game: game, showSnackbarMessage: true));
      } catch (error) {
        emit(
          ErrorState(error: error),
        );
      }
    });
  }
}
