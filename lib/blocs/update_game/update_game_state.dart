part of 'update_game_bloc.dart';

abstract class UpdateGameState extends Equatable {
  const UpdateGameState();

  @override
  List<Object> get props => [];
}

class InitialState extends UpdateGameState {}

class LoadingState extends UpdateGameState {}

class LoadedState extends UpdateGameState {
  const LoadedState({
    required this.game,
    required this.showSnackbarMessage,
  });

  final GameModel game;
  final bool showSnackbarMessage;

  @override
  List<Object> get props => [
        game,
        showSnackbarMessage,
      ];
}

class ErrorState extends UpdateGameState {
  const ErrorState({
    required this.error,
  });

  final dynamic error;

  @override
  List<Object> get props => [
        error,
      ];
}
