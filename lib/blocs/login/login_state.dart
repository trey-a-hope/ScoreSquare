part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialState extends LoginState {
  final bool passwordVisible;
  final bool rememberMe;

  const InitialState({
    required this.passwordVisible,
    required this.rememberMe,
  });

  @override
  List<Object> get props => [
        passwordVisible,
        rememberMe,
      ];
}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {}

class ErrorState extends LoginState {
  final dynamic error;

  const ErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}
