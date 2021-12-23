part of 'update_game_bloc.dart';

abstract class UpdateGameEvent extends Equatable {
  const UpdateGameEvent();

  @override
  List<Object> get props => [];
}

class LoadPageEvent extends UpdateGameEvent {}

class SubmitEvent extends UpdateGameEvent {
  final int homeTeamScore;
  final int awayTeamScore;
  final int status;

  const SubmitEvent({
    required this.homeTeamScore,
    required this.awayTeamScore,
    required this.status,
  });

  @override
  List<Object> get props => [
        homeTeamScore,
        awayTeamScore,
        status,
      ];
}
