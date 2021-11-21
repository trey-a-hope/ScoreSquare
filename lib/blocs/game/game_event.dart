part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class LoadPageEvent extends GameEvent {}

class PurchaseBetEvent extends GameEvent {
  final int awayDigit;
  final int homeDigit;

  const PurchaseBetEvent({
    required this.awayDigit,
    required this.homeDigit,
  });

  @override
  List<Object> get props => [
        awayDigit,
        homeDigit,
      ];
}
