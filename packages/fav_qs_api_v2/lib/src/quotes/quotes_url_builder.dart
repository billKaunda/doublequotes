class QuotesUrlBuilder {
  const QuotesUrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://favqs.com/api/quotes';

  final String _baseUrl;

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
        searchTerm != null ? '?filter=$searchTerm' : '';

    final tagQueryStringPart = tag != null ? '?filter=$tag&type=tag' : '';

    final authorQueryStringPart =
        author != null ? '?filter=$author&type=author' : '';

    final favoritedByUsernameQueryStringPart = favoritedByUsername != null
        ? '?filter=$favoritedByUsername&type=user'
        : '';

    final privateQuotesWithSearchTermQueryStringPart = searchTerm != null
        ? '?filter=$searchTerm&private=$privateQuotesByProUser'
        : '?private=$privateQuotesByProUser';

    final hiddenByUsernameQueryStringPart =
        hiddenByUsername != null ? '?hidden=$hiddenByUsername' : '';

    final pageQueryStringPart = page != null ? '&page=$page' : '';

    return '$_baseUrl/$searchTermQueryStringPart$tagQueryStringPart$authorQueryStringPart$favoritedByUsernameQueryStringPart$privateQuotesWithSearchTermQueryStringPart$hiddenByUsernameQueryStringPart$pageQueryStringPart';
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
