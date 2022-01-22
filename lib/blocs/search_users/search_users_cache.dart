part of 'search_users_bloc.dart';

class SearchUsersCache {
  final _cache = <String, List<UserModel>>{};

  List<UserModel> get(String term) => _cache[term]!;

  void set(String term, List<UserModel> result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}
