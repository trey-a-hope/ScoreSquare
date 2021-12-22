part of 'create_game_bloc.dart';

abstract class CreateGameEvent extends Equatable {
  const CreateGameEvent();

  @override
  List<Object> get props => [];
}

class LoadPageEvent extends CreateGameEvent {}

class ChangeHomeTeamEvent extends CreateGameEvent {
  final NBATeamModel team;

  const ChangeHomeTeamEvent({
    required this.team,
  });

  @override
  List<Object> get props => [team];
}

class ChangeAwayTeamEvent extends CreateGameEvent {
  final NBATeamModel team;

  const ChangeAwayTeamEvent({
    required this.team,
  });

  @override
  List<Object> get props => [team];
}

class SubmitEvent extends CreateGameEvent {}
