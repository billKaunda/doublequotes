import 'package:key_value_storage/key_value_storage.dart';
import 'package:domain_models/domain_models.dart';

extension DialogueLinesCMToDomain on DialogueLinesCM {
  DialogueLines toDomainModel() {
    return DialogueLines(
      author: author,
      body: body,
    );
  }
}

extension QuoteListPageCMToDomain on QuoteListPageCM {
  QuoteListPage toDomainModel() {
    return QuoteListPage(
      page: page,
      isLastPage: isLastPage,
      quotes: quotes!.map((quote) => quote.toDomainModel()).toList(),
    );
  }
}

extension QotdCMToDomain on QotdCM {
  Qotd toDomainModel() {
    return Qotd(date: date, quote: quote.toDomainModel());
  }
}

extension QuoteCMToDomain on QuoteCM {
  Quote toDomainModel() {
    return Quote(
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
      userDetails: userDetails!.toDomainModel(),
      dialogueLines:
          dialogueLines!.map((line) => line.toDomainModel()).toList(),
      source: source,
      context: context,
    );
  }
}

extension UserDetailsCMToDomain on UserDetailsCM {
  UserDetails toDomainModel() {
    return UserDetails(
      isFavorite: isFavorite,
      isUpvoted: isUpvoted,
      isDownvoted: isDownvoted,
      isHidden: isHidden,
      personalTags: personalTags,
    );
  }
}
