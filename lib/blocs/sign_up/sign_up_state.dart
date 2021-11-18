part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends SignUpState {
  final bool termsServicesChecked;

  InitialState({
    required this.termsServicesChecked,
  });

  @override
  List<Object> get props => [
        termsServicesChecked,
      ];
}

class LoadingState extends SignUpState {}
