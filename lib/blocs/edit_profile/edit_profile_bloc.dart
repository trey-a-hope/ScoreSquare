import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:score_square/constants.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/auth_service.dart';
import 'package:score_square/services/modal_service.dart';
import 'package:score_square/services/storage_service.dart';
import 'package:score_square/services/user_service.dart';
import 'package:score_square/services/util_service.dart';

import '../../service_locator.dart';

part 'edit_profile_event.dart';
part 'edit_profile_page.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  late UserModel _user;

  EditProfileBloc() : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(LoadingState());

      _user = await locator<AuthService>().getCurrentUser();
      emit(
        LoadedState(
          user: _user,
        ),
      );
    });

    on<SaveEvent>((event, emit) async {
      emit(LoadingState());

      final String username = event.username;

      await locator<UserService>().updateUser(
        uid: _user.uid!,
        data: {
          'username': username,
        },
      );

      _user.username = username;

      emit(
        LoadedState(
          user: _user,
        ),
      );
    });

    on<UploadImageEvent>((event, emit) async {
      try {
        XFile? file = await ImagePicker().pickImage(source: event.imageSource);

        if (file == null) return;

        File? image = await ImageCropper.cropImage(
          sourcePath: file.path,
          aspectRatio: const CropAspectRatio(
            ratioX: 1.0,
            ratioY: 1.0,
          ),
        );

        if (image == null) return;

        emit(LoadingState());

        final String newImgUrl = await locator<StorageService>().uploadImage(
          file: image,
          imgPath: 'Images/Users/${_user.uid}/Profile',
        );

        await locator<UserService>().updateUser(
          uid: _user.uid!,
          data: {
            'imgUrl': newImgUrl,
          },
        );

        _user.imgUrl = newImgUrl;

        emit(
          LoadedState(
            user: _user,
          ),
        );
      } catch (error) {
        emit(ErrorState(error: error));
      }
    });
  }
}
