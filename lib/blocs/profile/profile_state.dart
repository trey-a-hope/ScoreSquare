part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class InitialState extends ProfileState {}

class LoadingState extends ProfileState {}

class LoadedState extends ProfileState {
  const LoadedState({
    required this.user,
    required this.bets,
  });

  final UserModel user;
  final List<BetModel> bets;

  @override
  List<Object> get props => [user, bets];
}

class ErrorState extends ProfileState {
  const ErrorState({
    required this.error,
  });

  final dynamic error;

  @override
  List<Object> get props => [
        error,
      ];
}
