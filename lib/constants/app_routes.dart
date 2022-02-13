import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:score_square/ui/login/login_page.dart';
import 'package:score_square/ui/main/main_page.dart';
import 'package:score_square/blocs/home/home_bloc.dart' as home;

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => const MainPage()),
    GetPage(name: '/login', page: () => const LoginPage()),
    GetPage(
        name: '/home',
        page: () => BlocProvider(
            create: (BuildContext context) => home.HomeBloc()
              ..add(
                home.LoadPageEvent(),
              ),
            child: const home.HomePage()))
  ];
}
