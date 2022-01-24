part of 'messages_bloc.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

class InitialState extends MessagesState {}

class LoadingState extends MessagesState {}

class NoRoomsState extends MessagesState {}

class HasRoomsState extends MessagesState {
  const HasRoomsState({
    required this.querySnapshot,
    required this.currentUser,
  });

  final QuerySnapshot querySnapshot;
  final UserModel currentUser;

  @override
  List<Object> get props => [querySnapshot, currentUser];
}

class ErrorState extends MessagesState {
  const ErrorState({
    required this.error,
  });

  final dynamic error;

  @override
  List<Object> get props => [
        error,
      ];
}
