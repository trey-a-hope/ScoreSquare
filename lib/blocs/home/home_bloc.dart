import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/widgets/custom_app_drawer.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_page.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadedState()) {
    on<HomeLoadPageEvent>((event, emit) {});
  }
}
