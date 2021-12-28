import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:score_square/models/user_model.dart';
import '../constants.dart';

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
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.imgUrl ?? dummyProfileImageUrl),
        ),
        title: Text(
          user.username,
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        subtitle: Text(
          'coins: ${user.coins}',
          textAlign: TextAlign.center,
        ),
        onTap: onTap,
      ),
    );
  }
}
