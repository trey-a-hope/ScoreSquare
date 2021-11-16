part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpStartState extends SignUpState {
  final bool termsServicesChecked;

  SignUpStartState({
    required this.termsServicesChecked,
  });

  @override
  List<Object> get props => [
        termsServicesChecked,
      ];
}

class LoadingState extends SignUpState {}
