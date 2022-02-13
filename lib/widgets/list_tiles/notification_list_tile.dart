import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:score_square/models/notification_model.dart';
import 'package:score_square/services/format_service.dart';
import 'package:score_square/services/modal_service.dart';
import 'package:score_square/services/user_service.dart';
import 'package:score_square/constants/app_themes.dart';

import '../../service_locator.dart';

class NotificationListTile extends StatefulWidget {
  final NotificationModel notification;
  final String uid;
  final VoidCallback refreshPage;

  const NotificationListTile({
    Key? key,
    required this.notification,
    required this.uid,
    required this.refreshPage,
  }) : super(key: key);

  @override
  _NotificationListTileState createState() => _NotificationListTileState();
}

class _NotificationListTileState extends State<NotificationListTile> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      enabled: true,
      key: ValueKey(widget.notification.hashCode),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async {
              await locator<UserService>().updateNotification(
                uid: widget.uid,
                notificationID: widget.notification.id!,
                data: {'isRead': false},
              );

              setState(() {
                widget.notification.isRead = false;
              });
            },
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            icon: MdiIcons.redo,
            label: 'Mark As Unread',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async {
              bool? confirm = await locator<ModalService>().showConfirmation(
                context: context,
                title: 'Delete notification?',
                message: 'Are you sure?',
              );

              if (confirm == null || confirm == false) {
                return;
              }

              await locator<UserService>().deleteNotification(
                  uid: widget.uid, notificationID: widget.notification.id!);

              widget.refreshPage();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: MdiIcons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        tileColor:
            widget.notification.isRead ? Colors.white : Colors.grey.shade300,
        leading: const Icon(MdiIcons.bellAlert),
        title: Text(
          widget.notification.title,
          style: AppThemes.textTheme.headline5,
        ),
        subtitle: Text(
          widget.notification.message,
          style: AppThemes.textTheme.subtitle1,
        ),
        trailing: Text(
          locator<FormatService>().timeAgo(date: widget.notification.created),
        ),
        onTap: () async {
          locator<ModalService>().showAlert(
            context: context,
            title: widget.notification.title,
            message: widget.notification.message,
          );

          await locator<UserService>().updateNotification(
              uid: widget.uid,
              notificationID: widget.notification.id!,
              data: {'isRead': true});

          setState(() {
            widget.notification.isRead = true;
          });
        },
      ),
    );
  }
}
