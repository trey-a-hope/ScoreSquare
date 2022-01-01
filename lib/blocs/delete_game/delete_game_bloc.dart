import 'package:equatable/equatable.dart';
import 'package:score_square/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/services/game_service.dart';
import 'package:score_square/services/modal_service.dart';
import 'package:score_square/widgets/basic_page.dart';
import 'package:score_square/widgets/list_tiles/game_list_tile.dart';

import '../../service_locator.dart';

part 'delete_game_event.dart';
part 'delete_game_state.dart';
part 'delete_game_page.dart';

class DeleteGameBloc extends Bloc<DeleteGameEvent, DeleteGameState> {
  final String gameID;
  late GameModel _game;

  DeleteGameBloc({required this.gameID}) : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      try {
        //Fetch the game based on ID.
        _game = await locator<GameService>().read(gameID: gameID);

        emit(
          LoadedState(
            showMessage: false,
            game: _game,
          ),
        );
      } catch (error) {
        emit(
          ErrorState(error: error),
        );
      }
    });
    on<DeleteEvent>((event, emit) async {
      try {
        await locator<GameService>().deleteGame(gameID: gameID);

        emit(
          LoadedState(
            showMessage: true,
            game: _game,
          ),
        );
      } catch (error) {
        emit(
          ErrorState(error: error),
        );
      }
    });
  }
}
