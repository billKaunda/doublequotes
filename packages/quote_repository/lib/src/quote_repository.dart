import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:fav_qs_api_v2/fav_qs_api_v2.dart';
import 'package:meta/meta.dart';

import 'mappers/mappers.dart';
import 'quote_local_storage.dart';

enum QuoteListPageFetchPolicy {
  cacheAndNetwork,
  networkOnly,
  networkPreferably,
  cachePreferably
}

class QuoteRepository {
  QuoteRepository({
    required QuotesKeyValueStorage quotesKeyValueStorage,
    required this.remoteQuotesApi,
    @visibleForTesting QuoteLocalStorage? localStorage,
  }) : _localStorage = localStorage ??
            QuoteLocalStorage(
              quotesKeyValueStorage: quotesKeyValueStorage,
            );

  final QuotesApiSection remoteQuotesApi;
  final QuoteLocalStorage _localStorage;

  Stream<QuoteListPage> getQuoteListPage({
    required QuoteListPageFetchPolicy fetchPolicy,
    int? page,
    String searchTerm = '',
    String? tag,
    String? author,
    bool? hiddenByUsername,
    bool? privateQuotesByProUser,
    String? favoritedByUsername,
  }) async* {
    final isFilteringByTag = tag != null;
    final isFilteringByAuthor = author != null;
    final isSearching = searchTerm.isNotEmpty;
    final isFetchPolicyNetworkOnly =
        fetchPolicy == QuoteListPageFetchPolicy.networkOnly;
    final shouldSkipCacheLookup =
        isFilteringByTag || isFilteringByAuthor || isSearching;

    // Fetch from network directly if there are search or filter parameters
    if (shouldSkipCacheLookup || isFetchPolicyNetworkOnly) {
      final newPage = await _getQuoteListPageFromNetwork(
        page: page,
        searchTerm: searchTerm,
        tag: tag,
        author: author,
        hiddenByUsername: hiddenByUsername,
        privateQuotesByProUser: privateQuotesByProUser,
        favoritedByUsername: favoritedByUsername,
      );
      yield newPage.toDomainModel();
      return;
    }

    // Cache-fetching configuration
    final isFilteringByFavorites = favoritedByUsername != null;
    final isFilteringByHidden = hiddenByUsername != null;
    final isFilteringByPrivate = privateQuotesByProUser != null;

    fetchPageFromCache() async {
      return [
        await _localStorage.getQuoteListPage(page!,
            favoritesOnly: isFilteringByFavorites),
        await _localStorage.getQuoteListPage(page,
            hiddenQuotesOnly: isFilteringByHidden),
        await _localStorage.getQuoteListPage(page,
            privateQuotesOnly: isFilteringByPrivate),
      ];
    }

    final [
      favoritesCachedPage,
      hiddenQuotesCachedPage,
      privateQuotesCachedPage
    ] = await fetchPageFromCache();

    final shouldEmitCachedPageInAdvance = [
      QuoteListPageFetchPolicy.cacheAndNetwork,
      QuoteListPageFetchPolicy.cachePreferably
    ].contains(fetchPolicy);

    if (shouldEmitCachedPageInAdvance) {
      final cachedPages = [
        favoritesCachedPage,
        hiddenQuotesCachedPage,
        privateQuotesCachedPage,
      ];

      for (final cachedPage in cachedPages) {
        if (cachedPage != null) {
          yield cachedPage.toDomainModel();
          /*
          If the the fetch policy is cachePreferably and you've
          already emitted the cached page successfully, there's
          nothing else to do. Just return and close the Stream
          */
          if (fetchPolicy == QuoteListPageFetchPolicy.cachePreferably) return;
        }
      }
    }

    //Network-fetching function with fallback to cached page if necessary
    Stream<QuoteListPage> fetchAndYieldNetworkPage({
      required Future<QuoteListPageRM> Function() fetchNetworkPage,
      required QuoteListPageCM? cachedPage,
    }) async* {
      try {
        final newPage = await fetchNetworkPage();
        yield newPage.toDomainModel();
      } catch (_) {
        /*
        If the fetchPolicy is networkPreferably and you got an error
        trying to fetch a page from the server, try to revert the
        error by emitting the cached page instead, if there is one.
        */
        if (fetchPolicy == QuoteListPageFetchPolicy.networkPreferably &&
            cachedPage != null) {
          yield cachedPage.toDomainModel();
        } else {
          /*
        Since you've already emitted the cachedPage if the policy
        is cacheAndNetwork or cachePreferably earlier, if the network
        call still fails, your only option now is tor rethrow the error.
        This way, the state manager will handle it properly by showing
        the user an error.
        */
          rethrow;
        }
      }
    }

    fetchAndYieldNetworkPage(
      fetchNetworkPage: () => _getQuoteListPageFromNetwork(
          page: page, favoritedByUsername: favoritedByUsername),
      cachedPage: favoritesCachedPage,
    );

    fetchAndYieldNetworkPage(
      fetchNetworkPage: () => _getQuoteListPageFromNetwork(
          page: page, hiddenByUsername: hiddenByUsername),
      cachedPage: hiddenQuotesCachedPage,
    );

    fetchAndYieldNetworkPage(
      fetchNetworkPage: () => _getQuoteListPageFromNetwork(
          page: page, privateQuotesByProUser: privateQuotesByProUser),
      cachedPage: privateQuotesCachedPage,
    );
  }

  Future<Quote> getQuoteDetails(int quoteId) async {
    final cachedQuote = await _localStorage.getQuote(quoteId);
    if (cachedQuote != null) {
      return cachedQuote.toDomainModel();
    } else {
      final apiQuote = await remoteQuotesApi.getQuote(quoteId);
      return apiQuote.toDomainModel();
    }
  }

  Future<Quote> favoriteQuote(int quoteId) async {
    final updatedCacheQuote =
        remoteQuotesApi.favoriteQuote(quoteId).toCacheUpdateFuture(
              _localStorage,
              shouldInvalidateFavoritesCache: true,
            );

    return updatedCacheQuote.toRemoteModelAsync();
  }

  Future<Quote> unfavoriteQuote(int quoteId) async {
    final updatedCacheQuote =
        remoteQuotesApi.unfavoriteQuote(quoteId).toCacheUpdateFuture(
              _localStorage,
              shouldInvalidateFavoritesCache: true,
            );

    return updatedCacheQuote.toRemoteModelAsync();
  }

  Future<Quote> upvoteQuote(int quoteId) async {
    final updatedCacheQuote =
        remoteQuotesApi.upvoteQuote(quoteId).toCacheUpdateFuture(
              _localStorage,
            );

    return updatedCacheQuote.toRemoteModelAsync();
  }

  Future<Quote> downvoteQuote(int quoteId) async {
    final updatedCacheQuote =
        remoteQuotesApi.downvoteQuote(quoteId).toCacheUpdateFuture(
              _localStorage,
            );

    return updatedCacheQuote.toRemoteModelAsync();
  }

  Future<Quote> clearvoteOnQuote(int quoteId) async {
    final updatedCacheQuote =
        remoteQuotesApi.clearvoteOnQuote(quoteId).toCacheUpdateFuture(
              _localStorage,
            );

    return updatedCacheQuote.toRemoteModelAsync();
  }

  Future<Quote> addPersonalTagsToQuote(
    int quoteId,
    List<String>? personalTags,
  ) async {
    final updatedCacheQuote = remoteQuotesApi
        .addPersonalTagsToQuote(quoteId, personalTags)
        .toCacheUpdateFuture(
          _localStorage,
        );

    return updatedCacheQuote.toRemoteModelAsync();
  }

  Future<Quote> hideQuote(int quoteId) async {
    final updatedCacheQuote =
        remoteQuotesApi.hideQuote(quoteId).toCacheUpdateFuture(
              _localStorage,
              shouldInvalidateHiddenQoutesCache: true,
            );

    return updatedCacheQuote.toRemoteModelAsync();
  }

  Future<Quote> unhideQuote(int quoteId) async {
    final updatedCacheQuote =
        remoteQuotesApi.unhideQuote(quoteId).toCacheUpdateFuture(
              _localStorage,
              shouldInvalidateHiddenQoutesCache: true,
            );

    return updatedCacheQuote.toRemoteModelAsync();
  }

  Future<Quote> addQuote(String author, String body) async {
    final updatedCacheQuote = remoteQuotesApi
        .addQuote(author, body)
        .toCacheUpdateFuture(_localStorage,
            shouldInvalidatePrivateQuotesCache: true);

    return updatedCacheQuote.toRemoteModelAsync();
  }

  Future<Quote> addDialogue(
    List<DialogueLineRequestRM> lines, {
    String? source,
    String? context,
    List<String>? tags,
  }) async {
    final updatedCacheQuote = remoteQuotesApi
        .addDialogue(
          lines,
          source: source,
          context: context,
          tags: tags,
        )
        .toCacheUpdateFuture(
          _localStorage,
        );

    return updatedCacheQuote.toRemoteModelAsync();
  }

  Future<Quote> updateQuote(
    int quoteId, {
    String? author,
    String? body,
  }) async {
    final updatedCacheQuote = remoteQuotesApi
        .updateQuote(
          quoteId,
          author: author,
          body: body,
        )
        .toCacheUpdateFuture(
          _localStorage,
          shouldInvalidateHiddenQoutesCache: true,
        );

    return updatedCacheQuote.toRemoteModelAsync();
  }

  Future<Quote> updateDialogue(
    int quoteId,
    List<DialogueLineRequestRM> lines, {
    String? source,
    String? context,
    List<String>? tags,
  }) async {
    final updatedCacheQuote = remoteQuotesApi
        .updateDialogue(
          quoteId,
          lines,
          source: source,
          context: context,
          tags: tags,
        )
        .toCacheUpdateFuture(_localStorage);

    return updatedCacheQuote.toRemoteModelAsync();
  }

  Future<void> deleteQuote(int quoteId) async {
    final cachedQuote = await _localStorage.getQuote(quoteId);

    if (cachedQuote != null) {
      await _localStorage.deleteQuote(quoteId);
      return;
    }

    try {
      await remoteQuotesApi.deleteQuote(quoteId);
    } on QuoteNotFoundFavQsException {
      throw QuoteNotFound();
    } on ProUserRequiredFavQsException {
      throw ProUserRequired();
    } catch (_) {
      rethrow;
    }
  }

  Future<Quote> makeQuotePublic(int quoteId) async {
    final updatedCacheQuote =
        remoteQuotesApi.makeQuotePublic(quoteId).toCacheUpdateFuture(
              _localStorage,
              shouldInvalidatePrivateQuotesCache: true,
            );

    return updatedCacheQuote.toRemoteModelAsync();
  }

  Future<void> clearCache() async {
    await _localStorage.clear();
  }

  Future<QuoteListPageRM> _getQuoteListPageFromNetwork({
    int? page,
    String searchTerm = '',
    String? tag,
    String? author,
    bool? hiddenByUsername,
    bool? privateQuotesByProUser,
    String? favoritedByUsername,
  }) async {
    try {
      //Get a new page from the api
      final apiPage = await remoteQuotesApi.getQuoteListPage(
        page: page,
        searchTerm: searchTerm,
        tag: tag,
        author: author,
        hiddenByUsername: hiddenByUsername,
        privateQuotesByProUser: privateQuotesByProUser,
        favoritedByUsername: favoritedByUsername,
      );

      final isFiltering =
          searchTerm.isNotEmpty || tag != null || author != null;
      final favoritesOnly = favoritedByUsername != null;
      final privateQuotesOnly = privateQuotesByProUser != null;
      final hiddenQuotesOnly = hiddenByUsername != null;

      /*
      Don't cache filtered results. If you tried to cache all the 
      searches the user could possibly perform, you'll quickly fill up 
      the device's storage. 
      
      Also, users are willing to wait longer for searches.
      */

      final shouldStoreOnCache = !isFiltering;
      if (shouldStoreOnCache) {
        final shouldEmptyCache = page == 1;
        /*
        Every time you get a fresh first page, clear all the subsequent
        ones previously stored on cache. This forces the subsequent
        pages to be fetched from the network in the future, so, you
        don't risk mixing updated and outdated pages.
        Not doing this can result into a problem, such as, if a quote
        that used to be on the second page moved to the first page, you'd
        risk showing that quote twice if you mixed the cached and fresh
        pages.
        */

        if (shouldEmptyCache) {
          await _localStorage.clearQuoteListPageList(
            favoritesOnly: favoritesOnly,
            hiddenQuotesOnly: hiddenQuotesOnly,
            privateQuotesOnly: privateQuotesOnly,
          );
        }

        final cachedPage = apiPage.toCacheModel();
        await _localStorage.upsertQuoteListPage(
          page!,
          cachedPage,
          favoritesOnly: favoritesOnly,
          hiddenQuotesOnly: hiddenQuotesOnly,
          privateQuotesOnly: privateQuotesOnly,
        );
      }

      //If not storing on cache, then return the network page
      return apiPage;
    } on UserSessionNotFoundFavQsException {
      throw UserSessionNotFound();
    } on ProUserRequiredFavQsException {
      throw ProUserRequired();
    } on UserNotFoundFavQsException {
      throw UserNotFound();
    } on QuoteNotFoundFavQsException {
      throw QuoteNotFound();
    } on AuthorNotFoundFavQsException {
      throw AuthorNotFound();
    } on TagNotFoundFavQsException {
      throw TagNotFound();
    } catch (error) {
      rethrow;
    }
  }
}

extension on Future<QuoteRM> {
  Future<QuoteCM> toCacheUpdateFuture(
    QuoteLocalStorage localStorage, {
    bool shouldInvalidateFavoritesCache = false,
    bool shouldInvalidateHiddenQoutesCache = false,
    bool shouldInvalidatePrivateQuotesCache = false,
  }) async {
    try {
      final updatedApiQuote = await this;
      final updatedCacheQuote = updatedApiQuote.toCacheModel();

      //Collect all the async cache actions in a list.
      // The logical negation operator (!) converts the flags
      // shouldInvalidate... into conditions for updating rather than
      // invalidating.
      final cacheActions = [
        localStorage.performActionOnQuote(
          updatedCacheQuote,
          shouldUpdateFavorites: !shouldInvalidateFavoritesCache,
          shouldUpdateHiddenQuotes: !shouldInvalidateHiddenQoutesCache,
          shouldUpdatePrivateQuotes: !shouldInvalidatePrivateQuotesCache,
        ),
        if (shouldInvalidateFavoritesCache)
          localStorage.clearQuoteListPageList(favoritesOnly: true),
        if (shouldInvalidateHiddenQoutesCache)
          localStorage.clearQuoteListPageList(hiddenQuotesOnly: true),
        if (shouldInvalidatePrivateQuotesCache)
          localStorage.clearQuoteListPageList(privateQuotesOnly: true),
      ];

      await Future.wait(cacheActions);
      return updatedCacheQuote;
    } on UserSessionNotFoundFavQsException {
      throw UserSessionNotFound();
    } on ProUserRequiredFavQsException {
      throw ProUserRequired();
    } on QuoteNotFoundFavQsException {
      throw QuoteNotFound();
    } on CannotUnfavPrivateQuotesFavQsException {
      throw CannotUnfavPrivateQuotes();
    } catch (error) {
      rethrow; // rethrow any unexpected errors
    }
  }
}

extension on Future<QuoteCM> {
  Future<Quote> toRemoteModelAsync() async {
    final cacheQuote = await this;
    return Future.value(
      Quote(
        quoteId: cacheQuote.quoteId,
        favoritesCount: cacheQuote.favoritesCount,
        enableDialogue: cacheQuote.enableDialogue,
        isFavorite: cacheQuote.isFavorite,
        tags: cacheQuote.tags,
        quoteUrl: cacheQuote.quoteUrl,
        upvotesCount: cacheQuote.upvotesCount,
        downvotesCount: cacheQuote.downvotesCount,
        author: cacheQuote.author,
        authorPermalink: cacheQuote.authorPermalink,
        body: cacheQuote.body,
        isPrivate: cacheQuote.isPrivate,
        userDetails: cacheQuote.userDetails?.toDomainModel(),
        dialogueLines: cacheQuote.dialogueLines
            ?.map((line) => line.toDomainModel())
            .toList(),
        source: cacheQuote.source,
        context: cacheQuote.context,
      ),
    );
  }
}
