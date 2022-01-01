part of 'edit_profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is LoadedState) {
            UserModel user = state.user;

            _usernameController.text = user.username;

            return SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Stack(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              if (user.imgUrl != null) {
                                locator<UtilService>().heroToImage(
                                  context: context,
                                  imgUrl: user.imgUrl!,
                                  tag: user.uid!,
                                );
                              }
                            },
                            child: CachedNetworkImage(
                              imageUrl: user.imgUrl == null
                                  ? dummyProfileImageUrl
                                  : user.imgUrl!,
                              imageBuilder: (context, imageProvider) =>
                                  GFAvatar(
                                radius: 40,
                                backgroundImage: imageProvider,
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            right: 1,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.red,
                              child: Center(
                                child: IconButton(
                                  icon: const Icon(
                                    MdiIcons.camera,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    showSelectImageDialog();
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter username',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
        listener: (context, state) {
          if (state is LoadedState) {
            if (state.showSnackbarMessage) {
              locator<ModalService>().showInSnackBar(
                context: context,
                message: 'Profile successfully updated.',
              );
            }
          }
        },
      ),
      title: 'Edit Profile',
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
              title: 'Save Profile',
              message: 'Are you sure?');

          if (confirm == null || confirm == false) {
            return;
          }

          context.read<EditProfileBloc>().add(
                SaveEvent(
                  username: _usernameController.text,
                ),
              );
        },
      ),
    );
  }

  showSelectImageDialog() {
    return Platform.isIOS ? iOSBottomSheet() : androidDialog();
  }

  iOSBottomSheet() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext buildContext) {
          return CupertinoActionSheet(
            title: const Text('Add Photo'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: const Text('Take Photo'),
                onPressed: () {
                  Navigator.pop(buildContext);
                  context.read<EditProfileBloc>().add(
                        const UploadImageEvent(imageSource: ImageSource.camera),
                      );
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Choose From Gallery'),
                onPressed: () {
                  Navigator.pop(buildContext);
                  context.read<EditProfileBloc>().add(
                        const UploadImageEvent(
                            imageSource: ImageSource.gallery),
                      );
                },
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () => Navigator.pop(buildContext),
            ),
          );
        });
  }

  androidDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add Photo'),
          children: <Widget>[
            SimpleDialogOption(
              child: const Text('Take Photo'),
              onPressed: () {
                Navigator.pop(context);
                context.read<EditProfileBloc>().add(
                      const UploadImageEvent(imageSource: ImageSource.camera),
                    );
              },
            ),
            SimpleDialogOption(
              child: const Text('Choose From Gallery'),
              onPressed: () {
                Navigator.pop(context);
                context.read<EditProfileBloc>().add(
                      const UploadImageEvent(imageSource: ImageSource.gallery),
                    );
              },
            ),
            SimpleDialogOption(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }
}
