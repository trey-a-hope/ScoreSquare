part of 'games_bloc.dart';

abstract class GamesState extends Equatable {
  const GamesState();

  @override
  List<Object> get props => [];
}

class GamesInitial extends GamesState {}

class GamesLoadingState extends GamesState {}

class GamesLoadedState extends GamesState {
  const GamesLoadedState({required this.games});

  final List<GameModel> games;

  @override
  List<Object> get props => [games];
}
