part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class LoadPageEvent extends AdminEvent {}

class GoToCreateGameStateEvent extends AdminEvent {
  const GoToCreateGameStateEvent();

  @override
  List<Object> get props => [];
}

class CreateGameEvent extends AdminEvent {
  const CreateGameEvent();

  @override
  List<Object> get props => [];
}
