import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:score_square/services/user_service.dart';
import 'package:score_square/theme.dart';
import 'blocs/home/home_bloc.dart' as home;
import 'constants.dart';
import 'models/user_model.dart';
import 'service_locator.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//TODO
//Use in-app purchases to allow users to buy "coins".
//Use google ads to make revenue as well.
//Use Stripe payments to pay customers for their coins.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  setUpLocator();

  //Build squares.
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      squares.add('$i$j');
    }
  }

  //Set version and build numbers.
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  version = packageInfo.version;
  buildNumber = packageInfo.buildNumber;

  //Initialize Hive.
  await Hive.initFlutter();

  //Open hive boxes.
  await Hive.openBox<String>(hiveBoxUserCredentials);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  MyAppState();

  static final Box<dynamic> _userCredentialsBox =
      Hive.box<String>(hiveBoxUserCredentials);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final CollectionReference _usersDB =
      FirebaseFirestore.instance.collection('users');

  late Stream<User?> stream;

  Future<User?> authStateChangesAsyncStream({required User? user}) async {
    if (user == null) return user;

    DocumentReference userDocRef = _usersDB.doc(user.uid);

    //Check if user already exists.
    bool userExists = (await userDocRef.get()).exists;

    //Set UID to hive box.
    _userCredentialsBox.put('uid', user.uid);

    if (userExists) {
      //Request permission from user.
      if (Platform.isIOS) {
        _firebaseMessaging.requestPermission();
      }

      //Fetch the fcm token for this device.
      String? token = await _firebaseMessaging.getToken();

      //Validate that it's not null.
      assert(token != null);

      //Update fcm token for this device in firebase.
      userDocRef.update({'fcmToken': token});

      return user;
    }

    //Create user in firebase
    UserModel newUser = UserModel(
      imgUrl: user.photoURL,
      created: DateTime.now(),
      modified: DateTime.now(),
      uid: user.uid,
      username: user.displayName!,
      coins: initialCoinStart,
      isAdmin: false,
    );

    await locator<UserService>().createUser(user: newUser);

    return user;
  }

  @override
  void initState() {
    super.initState();

    //Build stream.
    stream = FirebaseAuth.instance.authStateChanges().asyncMap(
          (user) => authStateChangesAsyncStream(user: user),
        );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Score Square',
      theme: ThemeData(
        primaryColor: colorWhite,
        textTheme: textTheme,
      ),
      home: StreamBuilder<User?>(
        stream: stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text(
                      snapshot.error.toString(),
                    ),
                  ),
                );
              } else if (!snapshot.hasData) {
                return SignInScreen(
                  headerBuilder: (context, constraints, _) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(appIcon),
                      ),
                    );
                  },
                  providerConfigs: const [
                    GoogleProviderConfiguration(
                        clientId: googleProviderConfigurationClientId)
                  ],
                );
              } else {
                return BlocProvider(
                  create: (BuildContext context) => home.HomeBloc()
                    ..add(
                      home.LoadPageEvent(),
                    ),
                  child: const home.HomePage(),
                );
              }
          }
        },
      ),
    );
  }
}
