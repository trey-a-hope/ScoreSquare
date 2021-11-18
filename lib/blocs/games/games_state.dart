part of 'games_bloc.dart';

abstract class GamesState extends Equatable {
  const GamesState();

  @override
  List<Object> get props => [];
}

class InitialState extends GamesState {}

class LoadingState extends GamesState {}

class LoadedState extends GamesState {
  const LoadedState({required this.games});

  final List<GameModel> games;

  @override
  List<Object> get props => [games];
}
