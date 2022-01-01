part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class InitialState extends HomeState {}

class LoadingState extends HomeState {}

class LoadedState extends HomeState {
  const LoadedState({
    required this.user,
  });

  final UserModel user;

  @override
  List<Object> get props => [user];
}
