import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:score_square/constants/globals.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/user_service.dart';
import 'package:score_square/services/util_service.dart';
import 'package:score_square/constants/app_themes.dart';
import 'package:score_square/widgets/basic_page.dart';
import 'package:score_square/blocs/edit_profile/edit_profile_bloc.dart'
    as edit_profile;
import 'package:score_square/widgets/user_circle_avatar.dart';
import '../../service_locator.dart';
import 'package:score_square/blocs/message/message_bloc.dart' as message;

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_page.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  String uid;
  late UserModel _user;

  ProfileBloc({required this.uid}) : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(LoadingState());

      //Fetch user.
      _user = await locator<UserService>().retrieveUser(uid: uid);

      emit(
        LoadedState(
          user: _user,
        ),
      );
    });
  }
}
