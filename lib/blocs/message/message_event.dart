part of 'message_bloc.dart';

@immutable
abstract class MessageEvent extends Equatable {}

class SendMessageEvent extends MessageEvent {
  final ChatMessage message;

  SendMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddedEvent extends MessageEvent {
  final QuerySnapshot querySnapshot;

  MessageAddedEvent({required this.querySnapshot});

  @override
  List<Object> get props => [querySnapshot];
}

class LoadPageEvent extends MessageEvent {
  LoadPageEvent();

  @override
  List<Object> get props => [];
}
