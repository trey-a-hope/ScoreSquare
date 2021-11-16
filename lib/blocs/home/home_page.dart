part of 'home_bloc.dart';

class HomePage extends StatefulWidget {
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
          if (state is HomeLoadingState) {
            return const CircularProgressIndicator();
          }

          if (state is HomeLoadedState) {
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
