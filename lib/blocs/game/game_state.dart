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
    required this.currentUser,
    required this.currentWinners,
  });

  final GameModel game;
  final List<BetModel> bets;
  final NBATeamModel homeTeam;
  final NBATeamModel awayTeam;
  final UserModel currentUser;
  final List<UserModel> currentWinners;

  @override
  List<Object> get props => [
        game,
        bets,
        homeTeam,
        awayTeam,
        currentUser,
        currentWinners,
      ];
}

class BetPurchaseSuccessState extends GameState {
  const BetPurchaseSuccessState({
    required this.bet,
  });

  final BetModel bet;

  @override
  List<Object> get props => [bet];
}

class ErrorState extends GameState {
  const ErrorState({
    required this.error,
  });

  final dynamic error;

  @override
  List<Object> get props => [
        error,
      ];
}
