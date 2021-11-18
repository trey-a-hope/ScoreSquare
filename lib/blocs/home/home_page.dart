part of 'home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: const CustomAppDrawer(),
      body: BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is LoadedState) {
            return const Center(
              child: Text(
                'Home Page',
                style: TextStyle(
                  color: Colors.black,
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
