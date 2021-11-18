import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive/hive.dart';
import 'package:score_square/blocs/admin/admin_bloc.dart' as admin;
import 'package:score_square/blocs/edit_profile/edit_profile_bloc.dart'
    as edit_profile;
import 'package:score_square/blocs/home/home_bloc.dart' as home;
import 'package:score_square/blocs/games/games_bloc.dart' as games;
import 'package:score_square/services/auth_service.dart';
import 'package:score_square/services/modal_service.dart';
import '../constants.dart';
import '../service_locator.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Box<String> userCredentialsBox =
        Hive.box<String>(hiveBoxUserCredentials);
    final String uid = userCredentialsBox.get('uid')!;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Hello there!'),
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: const NetworkImage(
                        'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg'),
                    backgroundColor: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (BuildContext context) => home.HomeBloc()
                        ..add(
                          home.LoadPageEvent(),
                        ),
                      child: const home.HomePage(),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.gamepad),
              title: const Text('Games'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (BuildContext context) => games.GamesBloc()
                        ..add(
                          games.LoadPageEvent(),
                        ),
                      child: const games.GamesPage(),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (BuildContext context) =>
                          edit_profile.EditProfileBloc()
                            ..add(
                              edit_profile.LoadPageEvent(),
                            ),
                      child: const edit_profile.EditProfilePage(),
                    ),
                  ),
                );
              },
            ),
            if (adminUids.contains(uid)) ...[
              ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: const Text('Admin'),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (BuildContext context) => admin.AdminBloc()
                          ..add(
                            admin.LoadPageEvent(),
                          ),
                        child: const admin.AdminPage(),
                      ),
                    ),
                  );
                },
              ),
            ],
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                bool? confirm = await locator<ModalService>().showConfirmation(
                    context: context,
                    title: 'Logout',
                    message: 'Are you sure?');

                if (confirm == null || confirm == false) return;

                //Sign out.
                await locator<AuthService>().signOut();

                //Reload app.
                Phoenix.rebirth(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
