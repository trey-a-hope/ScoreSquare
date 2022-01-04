part of 'update_game_bloc.dart';

abstract class UpdateGameEvent extends Equatable {
  const UpdateGameEvent();

  @override
  List<Object> get props => [];
}

class LoadPageEvent extends UpdateGameEvent {}

class SubmitEvent extends UpdateGameEvent {
  const SubmitEvent();

  @override
  List<Object> get props => [];
}

class UpdateScoreEvent extends UpdateGameEvent {
  final bool isHome;
  final int score;

  const UpdateScoreEvent({
    required this.isHome,
    required this.score,
  });

  @override
  List<Object> get props => [
        isHome,
        score,
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
