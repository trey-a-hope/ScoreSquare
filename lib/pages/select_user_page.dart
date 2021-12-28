import 'package:flutter/material.dart';
import 'package:score_square/models/user_model.dart';
import 'package:score_square/widgets/user_list_tile.dart';

//TODO: Make this generic.
class SelectUserPage extends StatelessWidget {
  final List<UserModel> users;

  const SelectUserPage({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Select a user'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          UserModel user = users[index];

          return UserListTile(
            onTap: () {
              Navigator.of(context).pop(user);
            },
            user: user,
          );
        },
      ),
    );
  }
}
