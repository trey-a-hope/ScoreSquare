import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:score_square/ui/login/login_page.dart';
import 'package:score_square/ui/main/main_page.dart';
import 'package:score_square/blocs/home/home_bloc.dart' as home;
import 'package:score_square/ui/purchase_coins/purchase_coins_page.dart';
import 'package:score_square/ui/settings/settings_page.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => const MainPage()),
    GetPage(name: '/login', page: () => const LoginPage()),
    GetPage(name: '/settings', page: () => const SettingsPage()),
    GetPage(name: '/purchase_coins', page: () => const PurchaseCoinsPage()),
    GetPage(
      name: '/home',
      page: () => BlocProvider(
        create: (BuildContext context) => home.HomeBloc()
          ..add(
            home.LoadPageEvent(),
          ),
        child: const home.HomePage(),
      ),
    ),
  ];
}
