part of 'claim_winners_bloc.dart';

abstract class ClaimWinnersEvent extends Equatable {
  const ClaimWinnersEvent();

  @override
  List<Object> get props => [];
}

class LoadPageEvent extends ClaimWinnersEvent {}

class ClaimEvent extends ClaimWinnersEvent {
  const ClaimEvent({required this.game});

  final GameModel game;

  @override
  List<Object> get props => [game];
}
