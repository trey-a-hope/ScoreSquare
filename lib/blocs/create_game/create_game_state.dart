part of 'create_game_bloc.dart';

abstract class CreateGameState extends Equatable {
  const CreateGameState();

  @override
  List<Object> get props => [];
}

class InitialState extends CreateGameState {}

class LoadingState extends CreateGameState {}

class LoadedState extends CreateGameState {
  const LoadedState({
    required this.homeTeam,
    required this.awayTeam,
    required this.showSnackbarMessage,
    required this.startDateTime,
  });

  final NBATeamModel homeTeam;
  final NBATeamModel awayTeam;
  final bool showSnackbarMessage;
  final DateTime startDateTime;

  @override
  List<Object> get props => [
        homeTeam,
        awayTeam,
        showSnackbarMessage,
        startDateTime,
      ];
}

class ErrorState extends CreateGameState {
  const ErrorState({
    required this.error,
  });

  final dynamic error;

  @override
  List<Object> get props => [
        error,
      ];
}
