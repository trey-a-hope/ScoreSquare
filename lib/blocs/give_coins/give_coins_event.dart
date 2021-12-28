part of 'give_coins_bloc.dart';

abstract class GiveCoinsEvent extends Equatable {
  const GiveCoinsEvent();

  @override
  List<Object> get props => [];
}

class LoadPageEvent extends GiveCoinsEvent {}

class SubmitEvent extends GiveCoinsEvent {
  final int coins;

  const SubmitEvent({
    required this.coins,
  });

  @override
  List<Object> get props => [coins];
}
