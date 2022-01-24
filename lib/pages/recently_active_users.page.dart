import 'package:flutter/material.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/services/user_service.dart';
import 'package:score_square/widgets/basic_page.dart';
import 'package:score_square/widgets/list_tiles/user_list_tile.dart';
import '../service_locator.dart';

class RecentlyActiveUsersPage extends StatefulWidget {
  const RecentlyActiveUsersPage({Key? key}) : super(key: key);

  @override
  _RecentlyActiveUsersPageState createState() =>
      _RecentlyActiveUsersPageState();
}

class _RecentlyActiveUsersPageState extends State<RecentlyActiveUsersPage> {
  _RecentlyActiveUsersPageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      title: 'Recently Active Users',
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      child: FutureBuilder<List<UserModel>>(
        future: locator<UserService>().retrieveUsers(orderBy: 'modified'),
        builder:
            (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                List<UserModel> recentlyActiveUsers = snapshot.data!;
                return ListView.builder(
                  itemCount: recentlyActiveUsers.length,
                  itemBuilder: (context, index) {
                    return UserListTile(user: recentlyActiveUsers[index]);
                  },
                );
              }
          }
        },
      ),
    );
  }
}
