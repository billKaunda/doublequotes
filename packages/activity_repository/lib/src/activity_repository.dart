import 'package:fav_qs_api_v2/fav_qs_api_v2.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:domain_models/domain_models.dart';
import 'package:meta/meta.dart';
import 'mappers/mappers.dart';
import 'activity_local_storage.dart';

enum FetchPolicy {
  networkOnly,
  cacheAndNetwork,
  networkPreferably,
  cachePreferably,
}

class ActivityRepository {
  ActivityRepository({
    required ActivityKeyValueStorage activityKeyValueStorage,
    required this.remoteActivityApi,
    @visibleForTesting ActivityLocalStorage? localStorage,
  }) : _localStorage = localStorage ??
            ActivityLocalStorage(
                activityKeyValueStorage: activityKeyValueStorage);

  final ActivityApiSection remoteActivityApi;
  final ActivityLocalStorage _localStorage;

  Stream<T> fetchPage<T>({
    required FetchPolicy policy,
    required Future<T> Function() fetchFromNetwork,
    required Future<T?> Function(int) fetchFromCache,
    required Future<void> Function(int, T) updateCache,
    required Future<void> Function() clearCache,
    required int page,
    bool isFiltering = false,
  }) async* {
    final isNetworkOnly = policy == FetchPolicy.networkOnly;

    if (isFiltering || isNetworkOnly) {
      yield await fetchFromNetwork();
      return;
    }

    final shouldEmitCacheFirst = [
      FetchPolicy.cacheAndNetwork,
      FetchPolicy.cachePreferably,
    ].contains(policy);

    final cachedPage = await fetchFromCache(page);

    if (shouldEmitCacheFirst && cachedPage != null) {
      yield cachedPage;
      if (policy == FetchPolicy.cachePreferably) return;
    }

    try {
      final freshPage = await fetchFromNetwork();
      yield freshPage;
      if (!isFiltering) {
        if (page == 1) await clearCache();
      }

      await updateCache(page, freshPage);
    } catch (error) {
      if (policy == FetchPolicy.networkPreferably && cachedPage != null) {
        yield cachedPage;
      } else {
        rethrow;
      }
    }
  }

  Stream<ActivitiesListPage> getActivitiesListPage({
    required FetchPolicy policy,
    int? page,
    String searchTerm = '',
    String? author,
    String? tag,
    String? username,
  }) async* {
    yield* fetchPage<ActivitiesListPage>(
      policy: policy,
      page: page!,
      isFiltering: tag != null ||
          author != null ||
          username != null ||
          searchTerm.isNotEmpty,
      fetchFromNetwork: () => _getActivitiesListPageFromNetwork(
        page: page,
        searchTerm: searchTerm,
        tag: tag,
        author: author,
        username: username,
      ).toDomainModelAsync(),
      fetchFromCache: (page) =>
          _localStorage.getActivitiesListPage(page).toDomainModelAsync(),
      updateCache: (page, data) =>
          _localStorage.upsertActivitiesListPage(page, data.toCacheModel()),
      clearCache: _localStorage.clearActivitiesListPageList,
    );
  }

  Stream<FollowersListPage> getFollowersListPage({
    required FetchPolicy policy,
    int? page,
    String searchTerm = '',
    String? tag,
    String? author,
    String? username,
  }) async* {
    yield* fetchPage<FollowersListPage>(
      policy: policy,
      page: page!,
      isFiltering: searchTerm.isNotEmpty ||
          tag != null ||
          author != null ||
          username != null,
      fetchFromNetwork: () => _getFollowersListPageFromNetwork(
              page: page, tag: tag, author: author, username: username)
          .toDomainModelAsync(),
      fetchFromCache: (page) =>
          _localStorage.getFollowersListPage(page).toDomainModelAsync(),
      updateCache: (page, data) =>
          _localStorage.upsertFollowersListPage(page, data.toCacheModel()),
      clearCache: _localStorage.clearFollowersListPageList,
    );
  }

  Stream<FollowingListPage> getFollowingListPage({
    required FetchPolicy policy,
    int? page,
    String? username,
  }) async* {
    yield* fetchPage<FollowingListPage>(
      policy: policy,
      page: page!,
      isFiltering: username != null,
      fetchFromNetwork: () =>
          _getFollowingListPageFromNetwork(page: page, username: username)
              .toDomainModelAsync(),
      fetchFromCache: (page) =>
          _localStorage.getFollowingListPage(page).toDomainModelAsync(),
      updateCache: (page, data) =>
          _localStorage.upsertFollowingListPage(page, data.toCacheModel()),
      clearCache: _localStorage.clearFollowingListPageList,
    );
  }

  Future<ActivitiesListPageRM> _getActivitiesListPageFromNetwork({
    int? page,
    String searchTerm = '',
    String? tag,
    String? author,
    String? username,
  }) async {
    try {
      return await _fetchAndCacheNetworkPage(
        fetchPage: () => remoteActivityApi.getActivitiesListPage(
            page: page, author: author, username: username, tag: tag),
        clearCache: _localStorage.clearActivitiesListPageList,
        updateCache: (page, data) =>
            _localStorage.upsertActivitiesListPage(page, data.toCacheModel()),
        page: page!,
        isFiltering: tag != null ||
            author != null ||
            username != null ||
            searchTerm.isNotEmpty,
      );
    } on UserNotFoundFavQsException {
      throw UserNotFound();
    } on AuthorNotFoundFavQsException {
      throw AuthorNotFound();
    } on TagNotFoundFavQsException {
      throw TagNotFound();
    } catch (e) {
      rethrow;
    }
  }

  Future<FollowersListPageRM> _getFollowersListPageFromNetwork({
    int? page,
    String? tag,
    String? author,
    String? username,
  }) async {
    try {
      return await _fetchAndCacheNetworkPage(
        fetchPage: () => remoteActivityApi.getFollowersListPage(
            page: page, author: author, username: username, tag: tag),
        clearCache: _localStorage.clearFollowersListPageList,
        updateCache: (page, data) =>
            _localStorage.upsertFollowersListPage(page, data.toCacheModel()),
        page: page!,
        isFiltering: tag != null || author != null || username != null,
      );
    } on UserNotFoundFavQsException {
      throw UserNotFound();
    } on AuthorNotFoundFavQsException {
      throw AuthorNotFound();
    } on TagNotFoundFavQsException {
      throw TagNotFound();
    } catch (e) {
      rethrow;
    }
  }

  Future<FollowingListPageRM> _getFollowingListPageFromNetwork({
    int? page,
    String? username,
  }) async {
    try {
      return await _fetchAndCacheNetworkPage(
        fetchPage: () => remoteActivityApi.getFollowingListPage(
            page: page, username: username),
        clearCache: _localStorage.clearFollowingListPageList,
        updateCache: (page, data) =>
            _localStorage.upsertFollowingListPage(page, data.toCacheModel()),
        page: page!,
        isFiltering: username != null,
      );
    } on UserNotFoundFavQsException {
      throw UserNotFound();
    } catch (e) {
      rethrow;
    }
  }

  Future<T> _fetchAndCacheNetworkPage<T>({
    required Future<T> Function() fetchPage,
    required Future<void> Function() clearCache,
    required Future<void> Function(int, T) updateCache,
    required int page,
    required bool isFiltering,
  }) async {
    final apiPage = await fetchPage();
    if (!isFiltering) {
      if (page == 1) await clearCache();
      await updateCache(page, apiPage);
    }
    return apiPage;
  }
}

extension on Future<ActivitiesListPageRM> {
  Future<ActivitiesListPage> toDomainModelAsync() async {
    final remotePage = await this;
    return Future.value(
      ActivitiesListPage(
        activities: remotePage.activities
            ?.map((activity) => activity.toDomainModel())
            .toList(),
      ),
    );
  }
}

extension on Future<ActivitiesListPageCM?> {
  Future<ActivitiesListPage> toDomainModelAsync() async {
    final cachePage = await this;
    return Future.value(
      ActivitiesListPage(
        activities: cachePage!.activities
            ?.map((activity) => activity.toDomainModel())
            .toList(),
      ),
    );
  }
}

extension on Future<FollowersListPageRM> {
  Future<FollowersListPage> toDomainModelAsync() async {
    final remotePage = await this;
    return Future.value(
      FollowersListPage(
        page: remotePage.page,
        isLastPage: remotePage.isLastPage,
        users: remotePage.users,
        authors: remotePage.authors,
        tags: remotePage.tags,
      ),
    );
  }
}

extension on Future<FollowersListPageCM?> {
  Future<FollowersListPage> toDomainModelAsync() async {
    final cachePage = await this;
    return Future.value(
      FollowersListPage(
        page: cachePage?.page,
        isLastPage: cachePage?.isLastPage,
        users: cachePage?.users,
        authors: cachePage?.authors,
        tags: cachePage?.tags,
      ),
    );
  }
}

extension on Future<FollowingListPageRM> {
  Future<FollowingListPage> toDomainModelAsync() async {
    final remotePage = await this;
    return Future.value(
      FollowingListPage(
        page: remotePage.page,
        isLastPage: remotePage.isLastPage,
        followingItems: remotePage.followingItems
            ?.map((item) => item.toDomainModel())
            .toList(),
      ),
    );
  }
}

extension on Future<FollowingListPageCM?> {
  Future<FollowingListPage> toDomainModelAsync() async {
    final cachePage = await this;
    return Future.value(
      FollowingListPage(
        page: cachePage?.page,
        isLastPage: cachePage?.isLastPage,
        followingItems: cachePage?.followingItems
            ?.map((item) => item.toDomainModel())
            .toList(),
      ),
    );
  }
}
