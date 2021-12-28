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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<ProfileBloc>().add(LoadPageEvent());
            },
            icon: const Icon(Icons.refresh),
          ),
          Visibility(
            visible: isMine,
            child: IconButton(
              onPressed: () async {
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
              icon: const Icon(Icons.edit),
            ),
          )
        ],
      ),
      // drawer: const CustomAppDrawer(),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is LoadedState) {
            UserModel user = state.user;
            List<BetModel> bets = state.bets;

            return SafeArea(
              child: Center(
                child: Column(
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
                      child: Text('${user.username} | ${user.coins} coins'),
                    ),
                    const CustomTextHeader(text: 'My Bets'),
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
                  ],
                ),
              ),
            );
          }

          return Container();
        },
        listener: (context, state) {},
      ),
    );
  }
}
