part of 'message_bloc.dart';

@immutable
abstract class MessageState extends Equatable {}

class MessageInitial extends MessageState {
  @override
  List<Object> get props => [];
}

class LoadedState extends MessageState {
  final UserModel sender;
  final UserModel receiver;
  final DocumentReference roomDocRef;
  final List<MessageModel> messages;

  LoadedState({
    required this.receiver,
    required this.sender,
    required this.roomDocRef,
    required this.messages,
  });

  @override
  List<Object?> get props => [
        receiver,
        sender,
        roomDocRef,
        messages,
      ];
}

class LoadingState extends MessageState {
  @override
  List<Object> get props => [];
}

class ErrorState extends MessageState {
  final dynamic error;

  ErrorState({
    @required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}
