part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginLoadPageEvent extends LoginEvent {}

class LoginSubmitEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmitEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class LoginTryAgainEvent extends LoginEvent {}

class LoginUpdatePasswordVisibleEvent extends LoginEvent {}

class LoginUpdateRememberMeEvent extends LoginEvent {}
