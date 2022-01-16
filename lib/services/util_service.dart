import 'package:flutter/material.dart';
import 'package:score_square/services/user_service.dart';
import '../service_locator.dart';

abstract class IUtilService {
  void heroToImage({
    required BuildContext context,
    required String imgUrl,
    required String tag,
  });

  String getGreeting();

  void setOnlineStatus({required String? uid, required bool isOnline});
}

class UtilService extends IUtilService {
  @override
  void heroToImage({
    required BuildContext context,
    required String imgUrl,
    required String tag,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return _DetailScreen(imgUrl: imgUrl, tag: tag);
        },
      ),
    );
  }

  @override
  String getGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Future<void> setOnlineStatus(
      {required String? uid, required bool isOnline}) async {
    if (uid != null) {
      await locator<UserService>().updateUser(
        uid: uid,
        data: {
          'isOnline': isOnline,
        },
      );
      return;
    }
  }
}

class _DetailScreen extends StatelessWidget {
  const _DetailScreen({Key? key, required this.tag, required this.imgUrl})
      : super(key: key);

  final String tag;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: tag,
            child: Image.network(
              imgUrl,
            ),
          ),
        ),
      ),
    );
  }
}
