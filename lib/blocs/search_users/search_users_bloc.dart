import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:algolia/algolia.dart';
import 'package:score_square/constants/globals.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/auth_service.dart';
import 'package:score_square/widgets/basic_page.dart';
import 'package:score_square/widgets/list_tiles/user_list_tile.dart';
import '../../service_locator.dart';

part 'search_users_cache.dart';
part 'search_users_event.dart';
part 'search_users_page.dart';
part 'search_users_repository.dart';
part 'search_users_state.dart';

class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  final SearchUsersRepository _searchUsersRepository =
      SearchUsersRepository(cache: SearchUsersCache());
  late UserModel _currentUser;

  SearchUsersBloc() : super(SearchUsersStateStart()) {
    on<LoadPageEvent>((event, emit) async {
      try {
        _currentUser = await locator<AuthService>().getCurrentUser();
      } catch (error) {
        print(error.toString()); //todo: Display error message.
      }
    });
    on<TextChangedEvent>((event, emit) async {
      final String searchTerm = event.text;
      if (searchTerm.isEmpty) {
        emit(SearchUsersStateStart());
      } else {
        emit(SearchUsersStateLoading());
        try {
          final List<UserModel> results =
              await _searchUsersRepository.search(searchTerm);

          results.removeWhere((user) => user.uid == _currentUser.uid);

          if (results.isEmpty) {
            emit(SearchUsersStateNoResults());
          } else {
            emit(SearchUsersStateFoundResults(users: results));
          }
        } catch (error) {
          emit(SearchUsersStateError(error: error));
        }
      }
    });
  }
}
