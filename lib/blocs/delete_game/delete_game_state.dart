part of 'delete_game_bloc.dart';

abstract class DeleteGameState extends Equatable {
  const DeleteGameState();

  @override
  List<Object> get props => [];
}

class InitialState extends DeleteGameState {}

class LoadingState extends DeleteGameState {}

class LoadedState extends DeleteGameState {
  const LoadedState({
    required this.game,
    required this.showMessage,
  });

  final GameModel game;
  final bool showMessage;

  @override
  List<Object> get props => [game, showMessage];
}

class ErrorState extends DeleteGameState {
  const ErrorState({
    required this.error,
  });

  final dynamic error;

  @override
  List<Object> get props => [
        error,
      ];
}
