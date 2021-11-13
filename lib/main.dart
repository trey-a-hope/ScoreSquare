import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:score_square/services/auth_service.dart';
import 'blocs/home/home_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'constants.dart';
import 'service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  setUpLocater();

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
  await Hive.openBox<String>(HIVE_BOX_LOGIN_CREDENTIALS);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp();

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
      title: 'Critic',
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
                  create: (BuildContext context) => HomeBloc()
                    ..add(
                      HomeLoadPageEvent(),
                    ),
                  child: HomePage(),
                )
              : BlocProvider(
                  create: (BuildContext context) => LoginBloc()
                    ..add(
                      LoginLoadPageEvent(),
                    ),
                  child: LoginPage(),
                );
        },
      ),
    );
  }
}
