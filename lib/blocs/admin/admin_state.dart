part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class InitialState extends AdminState {}

class LoadingState extends AdminState {}

class LoadedState extends AdminState {
  const LoadedState();

  @override
  List<Object> get props => [];
}

class ErrorState extends AdminState {
  const ErrorState({
    required this.error,
  });

  final dynamic error;

  @override
  List<Object> get props => [
        error,
      ];
}
