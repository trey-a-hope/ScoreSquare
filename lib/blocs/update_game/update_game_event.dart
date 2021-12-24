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

  const SubmitEvent({
    required this.homeTeamScore,
    required this.awayTeamScore,
  });

  @override
  List<Object> get props => [
        homeTeamScore,
        awayTeamScore,
      ];
}

class ToggleIsOpenEvent extends UpdateGameEvent {
  final bool isOpen;

  const ToggleIsOpenEvent({
    required this.isOpen,
  });

  @override
  List<Object> get props => [
        isOpen,
      ];
}
