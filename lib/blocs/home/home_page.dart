part of 'home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    //Setup Flutter Local Notifications
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    //Register Firebase onMessage.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        String title = message.notification!.title!;
        String body = message.notification!.body!;
        showNotification(
          title,
          body,
        );
      }
    });

    //Register Firebase onMessageOpenedApp.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        String title = message.notification!.title!;
        String body = message.notification!.body!;
        showNotification(
          title,
          body,
        );
      }
    });

    //Register Firebase onBackgroundMessage.
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      String title = message.notification!.title!;
      String body = message.notification!.body!;
      showNotification(
        title,
        body,
      );
    });
  }

  Future<String?> onSelectNotification(String? payload) async {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  void showNotification(String title, String body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_ID', 'channel name',
      importance: Importance.max,
      playSound: true,
      //sound: AndroidNotificationSound.,
      showProgress: true,
      priority: Priority.high,
      ticker: 'test ticker',
    );

    const iOSChannelSpecifics = IOSNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: const CustomAppDrawer(),
      body: BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is LoadedState) {
            return const Center(
              child: Text(
                'Home Page',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          }

          return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}
