part of 'notifications_bloc.dart';

class NotificationsPage extends StatefulWidget {
  final String uid;

  const NotificationsPage({Key? key, required this.uid}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      title: 'Notifications',
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      rightIconButton: IconButton(
        icon: const Icon(Icons.check),
        onPressed: () async {
          bool? confirm = await locator<ModalService>().showConfirmation(
            context: context,
            title: 'Mark All As Read',
            message: 'Are you sure?',
          );

          if (confirm == null || confirm == false) {
            return;
          }
          context.read<NotificationsBloc>().add(
                MarkAllAsReadEvent(),
              );
        },
      ),
      child: BlocConsumer<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LoadedState) {
            List<NotificationModel> notifications = state.notifications;
            return notifications.isEmpty
                ? const Center(child: Text('No notifications.'))
                : ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return NotificationListTile(
                        uid: widget.uid,
                        notification: notifications[index],
                        refreshPage: () {
                          context
                              .read<NotificationsBloc>()
                              .add(LoadPageEvent());
                        },
                      );
                    },
                  );
          }

          return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}
