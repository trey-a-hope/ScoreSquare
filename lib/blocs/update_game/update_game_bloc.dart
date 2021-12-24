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

  late bool _isOpen;
  late GameModel _game;

  UpdateGameBloc({required this.gameID}) : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      try {
        //Fetch the game based on ID.
        _game = await locator<GameService>().read(gameID: gameID);
        _isOpen = _game.isOpen();

        emit(
          LoadedState(
            game: _game,
            showSnackbarMessage: false,
            isOpen: _isOpen,
          ),
        );
      } catch (error) {
        emit(
          ErrorState(error: error),
        );
      }
    });
    on<ToggleIsOpenEvent>((event, emit) async {
      _isOpen = !event.isOpen;
      emit(
        LoadedState(
          game: _game,
          showSnackbarMessage: false,
          isOpen: _isOpen,
        ),
      );
    });
    on<SubmitEvent>((event, emit) async {
      try {
        await locator<GameService>().update(gameID: gameID, data: {
          'homeTeamScore': event.homeTeamScore,
          'awayTeamScore': event.awayTeamScore,
          'ends': _isOpen ? null : DateTime.now()
        });

        _game = await locator<GameService>().read(gameID: gameID);

        emit(
          LoadedState(
            game: _game,
            showSnackbarMessage: true,
            isOpen: _game.isOpen(),
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
