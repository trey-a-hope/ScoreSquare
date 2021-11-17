part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadPageEvent extends EditProfileEvent {}

class SaveEvent extends EditProfileEvent {
  const SaveEvent({
    required this.username,
  });

  final String username;

  @override
  List<Object> get props => [username];
}

class UploadImageEvent extends EditProfileEvent {
  const UploadImageEvent({required this.imageSource});

  final ImageSource imageSource;

  @override
  List<Object> get props => [imageSource];
}
