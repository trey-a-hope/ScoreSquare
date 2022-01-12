part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class InitialState extends NotificationsState {}

class LoadingState extends NotificationsState {}

class LoadedState extends NotificationsState {
  const LoadedState({
    required this.notifications,
  });

  final List<NotificationModel> notifications;

  @override
  List<Object> get props => [
        notifications,
      ];
}

class ErrorState extends NotificationsState {
  const ErrorState({
    required this.error,
  });

  final dynamic error;

  @override
  List<Object> get props => [
        error,
      ];
}
