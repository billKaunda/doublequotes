class QuotesUrlBuilder {
  const QuotesUrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://favqs.com/api/quotes/';

  final String _baseUrl;
  /*
  String buildGetQuoteListPageUrl({
    int? page,
    String? searchTerm,
    String? tag,
    String? author,
    bool? hiddenByUsername,
    bool? privateQuotesByProUser,
    String? favoritedByUsername,
  }) {
    final searchTermQueryStringPart =
        searchTerm != null ? '?filter=${searchTerm.toUrlParameter()}' : '';

    final tagQueryStringPart =
        tag != null ? '?filter=${tag.toUrlParameter()}&type=tag' : '';

    final authorQueryStringPart =
        author != null ? '?filter=${author.toUrlParameter()}&type=author' : '';

    final favoritedByUsernameQueryStringPart = favoritedByUsername != null
        ? '?filter=${favoritedByUsername.toUrlParameter()}&type=user'
        : '';

    final privateQuotesWithSearchTermQueryStringPart = searchTerm != null
        ? '?filter=${searchTerm.toUrlParameter()}&private=${privateQuotesByProUser?.toUrlParameter()}'
        : '?private=${privateQuotesByProUser?.toUrlParameter()}';

    final hiddenByUsernameQueryStringPart = hiddenByUsername != null
        ? '?hidden=${hiddenByUsername.toUrlParameter()}'
        : '';

    final pageQueryStringPart = page != null ? '&page=$page' : '';

    if (searchTermQueryStringPart.isNotEmpty &&
        (tagQueryStringPart.isNotEmpty ||
            authorQueryStringPart.isNotEmpty ||
            favoritedByUsernameQueryStringPart.isNotEmpty)) {
      return '$_baseUrl/$tagQueryStringPart$authorQueryStringPart$favoritedByUsernameQueryStringPart$privateQuotesWithSearchTermQueryStringPart$hiddenByUsernameQueryStringPart$pageQueryStringPart';
    } else {
      return '$_baseUrl/$tagQueryStringPart$authorQueryStringPart$favoritedByUsernameQueryStringPart$privateQuotesWithSearchTermQueryStringPart$hiddenByUsernameQueryStringPart$pageQueryStringPart';
    }
  }
  */

  String buildGetQuoteListPageUrl({
    int? page,
    String? searchTerm,
    String? tag,
    String? author,
    bool? hiddenByUsername,
    bool? privateQuotesByProUser,
    String? favoritedByUsername,
  }) {
    final queryParams = <String, String>{};

    if (searchTerm != null) {
      queryParams['filter'] = searchTerm;
    } else if (privateQuotesByProUser == true) {
      queryParams['private'] = '1';
    }

    if (tag != null) {
      //queryParams['filter'] = tag;
      queryParams['type'] = 'tag';
    }

    if (author != null) {
      queryParams['type'] = 'author';
    }

    if (favoritedByUsername != null) {
      queryParams['type'] = 'user';
    }

    if (hiddenByUsername == true) {
      queryParams['hidden'] = '1';
    }
    /*
    if (page != null) {
      queryParams['page'] = '$page';
    }
    */
    if (privateQuotesByProUser == true) {
      queryParams['private'] = '1';
    }

    // Build the query string from queryParams.
    final queryString = queryParams.entries
        .map((entry) =>
            '${Uri.encodeComponent(entry.key)}=${entry.value.replaceAll(RegExp(r' '), '+').toLowerCase()}')
        .join('&');

    return '$_baseUrl${queryString.isNotEmpty ? '?$queryString' : ''}';
  }

  //TODO To be implemented as a pop up notification
  /*
  String buildGetQotdUrl() {
    return '$_baseUrl/qotd';
  }
  */

  String coreQuoteUrl(int quoteId, {String? action}) {
    if (action != null) {
      return '$_baseUrl/:$quoteId/$action';
    } else {
      return '$_baseUrl/:$quoteId';
    }
  }

  String buildGetQuoteUrl(int quoteId) => coreQuoteUrl(quoteId);

  String buildFavoriteQuoteUrl(int quoteId) =>
      coreQuoteUrl(quoteId, action: 'fav');

  String buildUnfavoriteQuoteUrl(int quoteId) =>
      coreQuoteUrl(quoteId, action: 'unfav');

  String buildUpvoteQuoteUrl(int quoteId) =>
      coreQuoteUrl(quoteId, action: 'upvote');

  String buildDownvoteQuoteUrl(int quoteId) =>
      coreQuoteUrl(quoteId, action: 'downvote');

  String buildClearvoteQuoteUrl(int quoteId) =>
      coreQuoteUrl(quoteId, action: 'clearvote');

  String buildAddPersonalTagToQuoteUrl(int quoteId) =>
      coreQuoteUrl(quoteId, action: 'tag');

  String buildHideQuoteUrl(int quoteId) =>
      coreQuoteUrl(quoteId, action: 'hide');

  String buildUnhideQuoteUrl(int quoteId) =>
      coreQuoteUrl(quoteId, action: 'unhide');

  String buildAddQuoteOrDialogueUrl() => _baseUrl;

  String buildUpdateQuoteOrDialogueUrl(int quoteId) => coreQuoteUrl(quoteId);

  String buildDeleteQuoteUrl(int quoteId) => coreQuoteUrl(quoteId);

  String buildMakeQuotePublicUrl(int quoteId) =>
      coreQuoteUrl(quoteId, action: 'publicize');
}
