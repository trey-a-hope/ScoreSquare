part of 'search_users_bloc.dart';

abstract class SearchUsersEvent extends Equatable {
  const SearchUsersEvent();
}

class LoadPageEvent extends SearchUsersEvent {
  const LoadPageEvent();

  @override
  List<Object> get props => [];
}

class TextChangedEvent extends SearchUsersEvent {
  final String text;

  const TextChangedEvent({required this.text});

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}
