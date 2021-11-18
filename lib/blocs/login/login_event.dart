part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoadPageEvent extends LoginEvent {}

class SubmitEvent extends LoginEvent {
  final String email;
  final String password;

  const SubmitEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class TryAgainEvent extends LoginEvent {}

class UpdatePasswordVisibleEvent extends LoginEvent {}

class UpdateRememberMeEvent extends LoginEvent {}
