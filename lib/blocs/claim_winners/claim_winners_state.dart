part of 'claim_winners_bloc.dart';

abstract class ClaimWinnersState extends Equatable {
  const ClaimWinnersState();

  @override
  List<Object> get props => [];
}

class ClaimWinnersInitial extends ClaimWinnersState {}

class InitialState extends ClaimWinnersState {}

class LoadingState extends ClaimWinnersState {}

class LoadedState extends ClaimWinnersState {
  const LoadedState({required this.games, required this.showMessage});

  final List<GameModel> games;
  final bool showMessage;

  @override
  List<Object> get props => [games, showMessage];
}

class ErrorState extends ClaimWinnersState {
  const ErrorState({
    required this.error,
  });

  final dynamic error;

  @override
  List<Object> get props => [
        error,
      ];
}
