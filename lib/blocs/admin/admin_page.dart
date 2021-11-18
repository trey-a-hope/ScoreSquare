part of 'admin_bloc.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Admin'),
        centerTitle: true,
      ),
      drawer: const CustomAppDrawer(),
      body: BlocConsumer<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is LoadedState) {
            return SafeArea(
              child: ListView(
                children: [
                  const Text('Games'),
                  CustomButton(
                    onPressed: () {
                      context.read<AdminBloc>().add(
                            const CreateGameEvent(),
                          );
                    },
                    text: 'Create Game',
                    buttonColor: Colors.black,
                    textColor: Colors.white,
                  ),
                  const Divider(),
                ],
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
