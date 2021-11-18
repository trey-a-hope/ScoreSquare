import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:score_square/services/auth_service.dart';
import 'blocs/home/home_bloc.dart' as home;
import 'blocs/login/login_bloc.dart' as login;
import 'constants.dart';
import 'service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

//Notes
//Use in-app purchases to allow users to buy "coins".
//Use google ads to make revenue as well.
//Use Stripe payments to pay customers for their coins.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  setUpLocator();

  bool isWeb;
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      isWeb = false;
    } else {
      isWeb = true;
    }
  } catch (e) {
    isWeb = true;
  }

  if (!isWeb) {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // final bool isDarkModeEnabled = prefs.getBool('isDarkModeEnabled') ?? false;

  //Initialize Hive.
  await Hive.initFlutter();

  //Open hive boxes.
  await Hive.openBox<String>(hiveBoxUserCredentials);

  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State createState() => MyAppState(
      // isDarkModeEnabled: isDarkModeEnabled,
      // isWeb: isWeb,
      );
}

class MyAppState extends State<MyApp> {
  MyAppState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Score Square',
      // theme: themeData,
      themeMode: ThemeMode.light,
      // darkTheme: darkThemeData,
      home: StreamBuilder(
        stream: locator<AuthService>().onAuthStateChanged(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          screenWidth = MediaQuery.of(context).size.width;
          screenHeight = MediaQuery.of(context).size.height;
          return snapshot.hasData
              ? BlocProvider(
                  create: (BuildContext context) => home.HomeBloc()
                    ..add(
                      home.LoadPageEvent(),
                    ),
                  child: const home.HomePage(),
                )
              : BlocProvider(
                  create: (BuildContext context) => login.LoginBloc()
                    ..add(
                      login.LoadPageEvent(),
                    ),
                  child: const login.LoginPage(),
                );
        },
      ),
    );
  }
}
