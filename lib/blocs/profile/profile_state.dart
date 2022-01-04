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
  });

  final UserModel user;

  @override
  List<Object> get props => [
        user,
      ];
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
