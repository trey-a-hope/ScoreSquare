part of 'search_users_bloc.dart';

class SearchUsersRepository {
  final SearchUsersCache cache;

  final Algolia _algolia = const Algolia.init(
    applicationId: algoliaAppID,
    apiKey: algoliaSearchOnlyAPIKey,
  );

  SearchUsersRepository({required this.cache});

  Future<List<UserModel>> search(String term) async {
    if (cache.contains(term)) {
      return cache.get(term);
    } else {
      AlgoliaQuery query = _algolia.instance.index('users').query(term);
      // query = query.setFacetFilter('isGem:$_isSearchingGems');

      final List<AlgoliaObjectSnapshot> results =
          (await query.getObjects()).hits;

      final List<UserModel> users =
          results.map((result) => UserModel.fromAlgolia(result)).toList();

      cache.set(term, users);
      return users;
    }
  }
}
