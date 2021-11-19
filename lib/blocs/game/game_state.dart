part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class InitialState extends GameState {}

class LoadingState extends GameState {}

class LoadedState extends GameState {
  const LoadedState({
    required this.game,
    required this.bets,
    required this.homeTeam,
    required this.awayTeam,
  });

  final GameModel game;
  final List<BetModel> bets;
  final NBATeamModel homeTeam;
  final NBATeamModel awayTeam;

  @override
  List<Object> get props => [
        game,
        bets,
        homeTeam,
        awayTeam,
      ];
}
