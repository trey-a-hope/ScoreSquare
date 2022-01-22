import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/blocs/search_users/search_users_bloc.dart';
import 'package:score_square/models/user_model.dart';
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

  Future<UserModel?> searchForUser({required BuildContext context});
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
    if (hour < 5 || hour > 16) {
      return 'Good Evening';
    }
    if (hour < 12) {
      return 'Good Morning';
    }
    return 'Good Afternoon';
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

  @override
  Future<UserModel?> searchForUser({required BuildContext context}) async {
    dynamic result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (BuildContext context) => SearchUsersBloc()
            ..add(
              const LoadPageEvent(),
            ),
          child: const SearchUsersPage(),
        ),
      ),
    );

    if (result == null) {
      return result;
    }

    return result as UserModel;
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
