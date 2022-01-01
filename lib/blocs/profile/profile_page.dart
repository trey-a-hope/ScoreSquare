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
            List<BetModel> bets = state.bets;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CachedNetworkImage(
                    imageUrl: user.imgUrl == null
                        ? dummyProfileImageUrl
                        : user.imgUrl!,
                    imageBuilder: (context, imageProvider) => GFAvatar(
                      radius: 40,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '${user.username} | ${user.coins} coins',
                    style: textTheme.headline4,
                  ),
                ),
                Text(
                  'My Bets',
                  style: textTheme.headline2,
                ),
                bets.isEmpty
                    ? const Text('No bets.')
                    : SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: bets.length,
                          itemBuilder: (context, index) {
                            return BetView(bet: bets[index]);
                          },
                        ),
                      ),
                Visibility(
                  visible: isMine,
                  child: ElevatedButton.icon(
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
                  ),
                )
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
