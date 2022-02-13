import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:score_square/constants/app_routes.dart';
import 'package:score_square/services/util_service.dart';
import 'package:score_square/constants/app_themes.dart';
import 'constants/globals.dart';
import 'service_locator.dart';
import 'package:get/get.dart';

//TODO
//Use in-app purchases to allow users to buy "coins".
//Use google ads to make revenue as well.
//Use Stripe payments to pay customers for their coins.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Wait for firebase app to initialize.
  await Firebase.initializeApp();

  /// Initialize dependencies.
  setUpLocator();

  /// Set version and build numbers.
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  version = packageInfo.version;
  buildNumber = packageInfo.buildNumber;

  /// Initialize Hive.
  await Hive.initFlutter();

  /// Open hive boxes.
  await Hive.openBox<String>(hiveBoxUserCredentials);

  /// Set status bar color to black.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ),
  );

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  MyApp({Key? key}) : super(key: key);

  static final Box<dynamic> _userCredentialsBox =
      Hive.box<String>(hiveBoxUserCredentials);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String? uid = _userCredentialsBox.get('uid');
    if (state == AppLifecycleState.resumed) {
      locator<UtilService>().setOnlineStatus(uid: uid, isOnline: true);
    } else {
      locator<UtilService>().setOnlineStatus(uid: uid, isOnline: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Score Square',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
        textTheme: AppThemes.textTheme,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      initialRoute: '/',
      getPages: AppRoutes.routes,
    );
  }
}
