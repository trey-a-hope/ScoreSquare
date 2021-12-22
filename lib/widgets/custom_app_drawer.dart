import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/blocs/profile/profile_bloc.dart' as profile;
import 'package:score_square/blocs/home/home_bloc.dart' as home;
import 'package:score_square/blocs/games/games_bloc.dart' as games;
import 'package:score_square/models/user_model.dart';
import 'package:score_square/pages/admin_page.dart';
import 'package:score_square/services/auth_service.dart';
import 'package:score_square/services/modal_service.dart';
import 'package:score_square/services/util_service.dart';
import '../service_locator.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: locator<AuthService>().getCurrentUser(), // async work
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading....');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              UserModel user = snapshot.data!;

              String imgUrl = user.imgUrl == null
                  ? 'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg'
                  : user.imgUrl!;

              return Drawer(
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      DrawerHeader(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Hello, ${user.username}'),
                            ),
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: NetworkImage(
                                imgUrl,
                              ),
                              backgroundColor: Colors.transparent,
                              child: GestureDetector(
                                onTap: () {
                                  locator<UtilService>().heroToImage(
                                    context: context,
                                    imgUrl: imgUrl,
                                    tag: imgUrl,
                                  );
                                },
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
                                create: (BuildContext context) =>
                                    home.HomeBloc()
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
                        leading: const Icon(Icons.sports_basketball),
                        title: const Text('Games'),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (BuildContext context) =>
                                    games.GamesBloc()
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
                        title: const Text('Profile'),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (BuildContext context) =>
                                    profile.ProfileBloc()
                                      ..add(
                                        profile.LoadPageEvent(),
                                      ),
                                child: const profile.ProfilePage(),
                              ),
                            ),
                          );
                        },
                      ),
                      if (user.isAdmin) ...[
                        ListTile(
                          leading: const Icon(Icons.admin_panel_settings),
                          title: const Text('Admin'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AdminPage(),
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
                          bool? confirm = await locator<ModalService>()
                              .showConfirmation(
                                  context: context,
                                  title: 'Logout',
                                  message: 'Are you sure?');

                          if (confirm == null || confirm == false) return;

                          //Sign out.
                          await locator<AuthService>().signOut();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
