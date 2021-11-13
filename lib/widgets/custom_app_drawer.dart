import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_square/blocs/home/home_bloc.dart';

import '../constants.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    create: (BuildContext context) => HomeBloc()
                      ..add(
                        HomeLoadPageEvent(),
                      ),
                    child: HomePage(),
                  ),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.people, color: iconColor),
          //   title: Text('Players'),
          //   onTap: () {
          //     Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(
          //         builder: (context) => PlayersPage(),
          //       ),
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.perm_data_setting, color: iconColor),
          //   title: Text('Teams'),
          //   onTap: () {
          //     Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(
          //         builder: (context) => TeamsPage(),
          //       ),
          //     );
          //   },
          // ),
          const ListTile(
            title: const Text('Games'),
            // onTap: const () {
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) => GamesPage(),
            //   ),
            // );
            // },
          ),
          const Spacer(),
          // const SafeArea(
          //   child: Padding(
          //     padding: EdgeInsets.only(bottom: 20),
          //     child: Text(
          //       'Version - $version + $buildNumber',
          //       style: TextStyle(
          //         color: Colors.deepPurpleAccent,
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
