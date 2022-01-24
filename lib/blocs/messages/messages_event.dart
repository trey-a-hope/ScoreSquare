part of 'messages_bloc.dart';

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}

class LoadPageEvent extends MessagesEvent {}

class RoomAddedEvent extends MessagesEvent {
  final QuerySnapshot querySnapshot;

  const RoomAddedEvent({required this.querySnapshot});

  @override
  List<Object> get props => [querySnapshot];
}
