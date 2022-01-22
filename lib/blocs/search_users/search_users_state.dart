part of 'search_users_bloc.dart';

abstract class SearchUsersState extends Equatable {
  const SearchUsersState();

  @override
  List<Object> get props => [];
}

class SearchUsersStateNoResults extends SearchUsersState {}

class SearchUsersStateStart extends SearchUsersState {}

class SearchUsersStateLoading extends SearchUsersState {}

class SearchUsersStateFoundResults extends SearchUsersState {
  final List<UserModel> users;

  const SearchUsersStateFoundResults({
    required this.users,
  });

  @override
  List<Object> get props => [users];

  @override
  String toString() => 'SearchUsersStateSuccess { items: ${users.length} }';
}

class SearchUsersStateError extends SearchUsersState {
  final dynamic error;

  const SearchUsersStateError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
