import 'package:fav_qs_api_v2/fav_qs_api_v2.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension DialogueLinesRMToCM on DialogueLinesRM {
  DialogueLinesCM toCacheModel() {
    return DialogueLinesCM(
      author: author,
      body: body,
    );
  }
}

extension QuoteListPageRMToCM on QuoteListPageRM {
  QuoteListPageCM toCacheModel() {
    return QuoteListPageCM(
      page: page,
      isLastPage: isLastPage,
      quotes: quotes!.map((quote) => quote.toCacheModel()).toList(),
    );
  }
}

extension QotdRMToCM on QotdRM {
  QotdCM toCacheModel() {
    return QotdCM(date: date, quote: quote.toCacheModel());
  }
}

extension QuoteRMToCM on QuoteRM {
  QuoteCM toCacheModel() {
    return QuoteCM(
      quoteId: quoteId,
      favoritesCount: favoritesCount,
      enableDialogue: enableDialogue,
      isFavorite: isFavorite,
      tags: tags,
      quoteUrl: quoteUrl,
      upvotesCount: upvotesCount,
      downvotesCount: downvotesCount,
      author: author,
      authorPermalink: authorPermalink,
      body: body,
      isPrivate: isPrivate,
      userDetails: userDetails!.toCacheModel(),
      dialogueLines:
          dialogueLines!.map((line) => line.toCacheModel()).toList(),
      source: source,
      context: context,
    );
  }
}

extension UserDetailsRMToCM on UserDetailsRM {
  UserDetailsCM toCacheModel() {
    return UserDetailsCM(
      isFavorite: isFavorite,
      isUpvoted: isUpvoted,
      isDownvoted: isDownvoted,
      isHidden: isHidden,
      personalTags: personalTags,
    );
  }
}