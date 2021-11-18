part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitEvent extends SignUpEvent {
  final String username;
  final String email;
  final String password;
  final BuildContext context;

  SubmitEvent({
    required this.username,
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object> get props => [
        username,
        email,
        password,
        context,
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
