import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/format_service.dart';
import 'package:score_square/services/util_service.dart';
import '../../service_locator.dart';
import '../user_circle_avatar.dart';

class UserListTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onTap;
  final SlidableAction? slidableAction;

  const UserListTile({
    Key? key,
    required this.user,
    this.onTap,
    this.slidableAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: slidableAction != null,
      key: ValueKey(user.hashCode),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          if (slidableAction != null) ...[
            slidableAction!,
          ]
        ],
      ),
      child: ListTile(
        leading: UserCircleAvatar(
          uid: user.uid!,
          showOnlineBadge: true,
          onTap: () {
            if (user.imgUrl != null) {
              locator<UtilService>().heroToImage(
                context: context,
                imgUrl: user.imgUrl!,
                tag: user.imgUrl!,
              );
            }
          },
        ),
        title: Text(
          user.username,
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.start,
        ),
        subtitle: Text(
          '${user.coins} coins',
          textAlign: TextAlign.start,
        ),
        trailing: Text(
          'active ${locator<FormatService>().timeAgo(date: user.modified)}',
          textAlign: TextAlign.center,
        ),
        onTap: onTap,
      ),
    );
  }
}
