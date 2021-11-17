part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class InitialState extends EditProfileState {}

class LoadingState extends EditProfileState {}

class LoadedState extends EditProfileState {
  const LoadedState({required this.user});

  final UserModel user;

  @override
  List<Object> get props => [user];
}

class ErrorState extends EditProfileState {
  const ErrorState({
    required this.error,
  });

  final dynamic error;

  @override
  List<Object> get props => [
        error,
      ];
}
