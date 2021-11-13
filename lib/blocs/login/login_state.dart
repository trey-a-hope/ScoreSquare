part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {
  final bool passwordVisible;
  final bool rememberMe;

  const LoginInitialState({
    required this.passwordVisible,
    required this.rememberMe,
  });

  @override
  List<Object> get props => [
        passwordVisible,
        rememberMe,
      ];
}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final dynamic error;

  const LoginErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}
