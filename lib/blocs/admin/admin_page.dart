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
              child: Column(
                children: [
                  const Text('Games'),
                  ElevatedButton.icon(onPressed: (){
                    context.read<AdminBloc>().add(
                      const CreateGameEvent(),
                    );
                  }, icon: const Icon(Icons.save), label: const Text('Save'),),

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
