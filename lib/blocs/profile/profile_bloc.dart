import 'package:equatable/equatable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:hive/hive.dart';
import 'package:score_square/constants.dart';
import 'package:score_square/models/bet_model.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/bet_service.dart';
import 'package:score_square/services/user_service.dart';
import 'package:score_square/theme.dart';
import 'package:score_square/widgets/basic_page.dart';
import 'package:score_square/widgets/bet_view.dart';
import 'package:score_square/blocs/edit_profile/edit_profile_bloc.dart'
    as edit_profile;
import '../../service_locator.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_page.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  String uid;
  late UserModel _user;
  late List<BetModel> _bets;

  ProfileBloc({required this.uid}) : super(InitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(LoadingState());

      //Fetch user.
      _user = await locator<UserService>().retrieveUser(uid: uid);

      //Fetch bets for this user.
      _bets = await locator<BetService>().listByUser(uid: _user.uid!);

      emit(
        LoadedState(
          user: _user,
          bets: _bets,
        ),
      );
    });
  }
}
