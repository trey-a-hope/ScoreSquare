part of 'give_coins_bloc.dart';

abstract class GiveCoinsState extends Equatable {
  const GiveCoinsState();

  @override
  List<Object> get props => [];
}

class InitialState extends GiveCoinsState {}

class LoadingState extends GiveCoinsState {}

class LoadedState extends GiveCoinsState {
  const LoadedState({
    required this.user,
    this.snackbarMessage,
  });

  final UserModel user;
  final String? snackbarMessage;

  @override
  List<Object> get props => [
        user,
      ];
}

class ErrorState extends GiveCoinsState {
  const ErrorState({
    required this.error,
  });

  final dynamic error;

  @override
  List<Object> get props => [
        error,
      ];
}
