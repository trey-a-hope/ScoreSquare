part of 'delete_game_bloc.dart';

abstract class DeleteGameEvent extends Equatable {
  const DeleteGameEvent();

  @override
  List<Object> get props => [];
}

class LoadPageEvent extends DeleteGameEvent {}

class DeleteEvent extends DeleteGameEvent {}
