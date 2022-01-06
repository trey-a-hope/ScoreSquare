part of 'games_bloc.dart';

abstract class GamesEvent extends Equatable {
  const GamesEvent();

  @override
  List<Object> get props => [];
}

class LoadPageEvent extends GamesEvent {}

class UpdateSortEvent extends GamesEvent {
  final String sort;
  final bool descending;

  const UpdateSortEvent({
    required this.sort,
    required this.descending,
  });

  @override
  List<Object> get props => [
        sort,
        descending,
      ];
}
