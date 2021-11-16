part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUp extends SignUpEvent {
  final String username;
  final String email;
  final String password;

  SignUp({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        username,
        email,
        password,
      ];
}

class NavigateToTermsServicePageEvent extends SignUpEvent {
  @override
  List<Object> get props => [];
}

class TermsServiceCheckboxEvent extends SignUpEvent {
  final bool checked;

  TermsServiceCheckboxEvent({
    required this.checked,
  });

  @override
  List<Object> get props => [
        checked,
      ];
}
