import 'package:flutter/material.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/user_service.dart';
import '../../constants.dart';
import '../service_locator.dart';

//TODO: Check and see there are too many reads to the database by fetching the user again...
class UserCircleAvatar extends StatelessWidget {
  final String uid;
  final VoidCallback onTap;
  final double? radius;

  const UserCircleAvatar({
    Key? key,
    required this.uid,
    required this.onTap,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: locator<UserService>().retrieveUser(uid: uid), // async work
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              child: CircleAvatar(
                radius: radius ?? 25,
                backgroundImage: const NetworkImage(dummyProfileImageUrl),
              ),
              padding: EdgeInsets.all(radius == null ? 2.0 : (radius! / 12.5)),
              decoration: const BoxDecoration(
                color: Colors.transparent, // border color
                shape: BoxShape.circle,
              ),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              UserModel user = snapshot.data!;

              return GestureDetector(
                onTap: onTap,
                child: Container(
                  child: CircleAvatar(
                    radius: radius ?? 25,
                    backgroundImage:
                        NetworkImage(user.imgUrl ?? dummyProfileImageUrl),
                  ),
                  padding:
                      EdgeInsets.all(radius == null ? 2.0 : (radius! / 12.5)),
                  decoration: BoxDecoration(
                    color: user.isOnline
                        ? Colors.green
                        : Colors.transparent, // border color
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
