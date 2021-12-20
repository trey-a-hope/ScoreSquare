part of 'profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          IconButton(
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
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      drawer: const CustomAppDrawer(),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is LoadedState) {
            UserModel user = state.user;

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
                      child: Text(user.username),
                    ),
                    const Spacer(),
                    // ElevatedButton.icon(
                    //   style: ButtonStyle(
                    //     backgroundColor:
                    //         MaterialStateProperty.all<Color>(Colors.green),
                    //   ),
                    //   onPressed: () async {
                    //     bool? confirm = await locator<ModalService>()
                    //         .showConfirmation(
                    //             context: context,
                    //             title: 'Save Profile',
                    //             message: 'Are you sure?');
                    //
                    //     if (confirm == null || confirm == false) {
                    //       return;
                    //     }
                    //
                    //     context.read<ProfileBloc>().add(
                    //           SaveEvent(
                    //             username: _usernameController.text,
                    //           ),
                    //         );
                    //   },
                    //   icon: const Icon(Icons.save),
                    //   label: const Text('E'),
                    // ),
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
