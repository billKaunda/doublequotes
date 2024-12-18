import 'package:fav_qs_api_v2/fav_qs_api_v2.dart';
import 'package:domain_models/domain_models.dart';

extension DialogueLinesRMToDomain on DialogueLineRM {
  DialogueLine toDomainModel() {
    return DialogueLine(
      author: author,
      body: body,
    );
  }
}

extension QuoteListPageRMToDomain on QuoteListPageRM {
  QuoteListPage toDomainModel() {
    return QuoteListPage(
      page: page,
      isLastPage: isLastPage,
      quotes: quotes!.map((quote) => quote.toDomainModel()).toList(),
    );
  }
}

extension QotdRMToDomain on QotdRM {
  Qotd toDomainModel() {
    return Qotd(date: date, quote: quote.toDomainModel());
  }
}

extension QuoteRMToDomain on QuoteRM {
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

extension UserDetailsRMToDomain on UserDetailsRM {
  UserDetails toDomainModel() {
    return UserDetails(
      isFavorite: isFavorite!,
      isUpvoted: isUpvoted!,
      isDownvoted: isDownvoted!,
      isHidden: isHidden,
      personalTags: personalTags,
    );
  }
}