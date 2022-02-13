import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/user_service.dart';
import '../constants/globals.dart';
import '../service_locator.dart';

//TODO: Check and see there are too many reads to the database by fetching the user again...
class UserCircleAvatar extends StatelessWidget {
  final String uid;
  final VoidCallback onTap;
  final double? radius;
  final bool showOnlineBadge;

  const UserCircleAvatar({
    Key? key,
    required this.uid,
    required this.onTap,
    this.radius,
    required this.showOnlineBadge,
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

              double badgePosition =
                  radius == null ? -5 : radius! - (radius! + 2);
              double badgeRadius = radius == null ? 10 : radius! / 2;
              double badgeIconSize = radius == null ? 10 : radius! / 2;

              return GestureDetector(
                onTap: onTap,
                child: showOnlineBadge
                    ? Badge(
                        position: BadgePosition.bottomEnd(
                          bottom: badgePosition,
                          end: badgePosition,
                        ),
                        badgeColor:
                            user.isOnline ? Colors.green : Colors.yellow,
                        badgeContent: Container(
                          width: badgeRadius,
                          height: badgeRadius,
                          alignment: Alignment.center,
                          child: user.isOnline
                              ? Icon(
                                  MdiIcons.contactlessPayment,
                                  color: Colors.white,
                                  size: badgeIconSize,
                                )
                              : Icon(
                                  MdiIcons.brightness2,
                                  color: Colors.black,
                                  size: badgeIconSize,
                                ),
                        ),
                        child: CircleAvatar(
                          radius: radius ?? 25,
                          backgroundImage:
                              NetworkImage(user.imgUrl ?? dummyProfileImageUrl),
                        ),
                      )
                    : CircleAvatar(
                        radius: radius ?? 25,
                        backgroundImage:
                            NetworkImage(user.imgUrl ?? dummyProfileImageUrl),
                      ),
              );
            }
        }
      },
    );
  }
}
