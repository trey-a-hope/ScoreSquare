part of 'profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static final Box<dynamic> _userCredentialsBox =
      Hive.box<String>(hiveBoxUserCredentials);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Determine if this is my profile page or not.
    bool isMine =
        context.read<ProfileBloc>().uid == _userCredentialsBox.get('uid');

    return BasicPage(
      title: 'Profile',
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      rightIconButton: IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () {
          context.read<ProfileBloc>().add(
                LoadPageEvent(),
              );
        },
      ),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LoadedState) {
            UserModel user = state.user;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: UserCircleAvatar(
                    uid: user.uid!,
                    radius: 40,
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
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    user.isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      color: user.isOnline ? Colors.lightGreen : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '${user.username} | ${user.coins} coins',
                    style: textTheme.headline4,
                  ),
                ),
                isMine
                    ? ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
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
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            colorDarkBlue,
                          ),
                        ),
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Profile'),
                      )
                    : ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (BuildContext context) =>
                                    message.MessageBloc(otherUser: user)
                                      ..add(
                                        message.LoadPageEvent(),
                                      ),
                                child: const message.MessagePage(),
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            colorDarkBlue,
                          ),
                        ),
                        icon: const Icon(Icons.send),
                        label: const Text('Send Message'),
                      ),
              ],
            );
          }

          return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}
