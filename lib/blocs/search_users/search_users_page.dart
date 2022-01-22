part of 'search_users_bloc.dart';

class SearchUsersPage extends StatelessWidget {
  const SearchUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      child: Column(
        children: <Widget>[
          _SearchBar(),
          const _SearchBody(),
        ],
      ),
      title: 'Search Users',
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.headline4!,
      controller: _textController,
      autocorrect: false,
      onChanged: (text) {
        context.read<SearchUsersBloc>().add(
              TextChangedEvent(text: text),
            );
      },
      cursorColor: Theme.of(context).textTheme.headline5!.color,
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).iconTheme.color,
        ),
        suffixIcon: GestureDetector(
          child: Icon(
            Icons.clear,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: _onClearTapped,
        ),
        border: InputBorder.none,
        hintText: 'Enter username',
        hintStyle: Theme.of(context).textTheme.headline4!,
      ),
    );
  }

  void _onClearTapped() {
    _textController.text = '';
    context.read<SearchUsersBloc>().add(const TextChangedEvent(text: ''));
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchUsersBloc, SearchUsersState>(
      builder: (BuildContext context, SearchUsersState state) {
        if (state is SearchUsersStateStart) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 100,
                ),
                Text('Please enter a username...',
                    style: Theme.of(context).textTheme.headline6),
              ],
            ),
          );
        }

        if (state is SearchUsersStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SearchUsersStateError) {
          return Expanded(
            child: Center(
              child: Text(state.error.message),
            ),
          );
        }

        if (state is SearchUsersStateNoResults) {
          return const Expanded(
            child: Center(
              child: Text('No results found. :('),
            ),
          );
        }

        if (state is SearchUsersStateFoundResults) {
          final List<UserModel> users = state.users;

          return Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                final UserModel user = users[index];

                return UserListTile(
                  user: user,
                  onTap: () {
                    Navigator.of(context).pop(user);
                  },
                );
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}
