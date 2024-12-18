import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:fav_qs_api_v2/src/extensions.dart';
import 'package:fav_qs_api_v2/src/fav_qs_api_v2_exceptions.dart';

import './models/quote_models.dart';
import './quotes_url_builder.dart';

class QuotesApiSection {
  static const _errorCodeJsonKey = 'error_code';

  QuotesApiSection({
    this.userSessionTokenSupplier,
    @visibleForTesting Dio? dio,
    @visibleForTesting QuotesUrlBuilder? quotesUrlBuilder,
  })  : _dio = dio ?? Dio(),
        _quotesUrlBuilder = quotesUrlBuilder ?? const QuotesUrlBuilder() {
    _dio.setUpAuthHeaders(userSessionTokenSupplier);
    _dio.interceptors.add(LogInterceptor(responseBody: false));
  }

  final UserSessionTokenSupplier? userSessionTokenSupplier;
  final Dio _dio;
  final QuotesUrlBuilder _quotesUrlBuilder;

  Future<QuoteListPageRM> getQuoteListPage({
    int? page,
    String? searchTerm,
    String? tag,
    String? author,
    bool? hiddenByUsername,
    bool? privateQuotesByProUser,
    String? favoritedByUsername,
  }) async {
    final url = _quotesUrlBuilder.buildGetQuoteListPageUrl(
      page: page,
      searchTerm: searchTerm,
      tag: tag,
      author: author,
      hiddenByUsername: hiddenByUsername,
      privateQuotesByProUser: privateQuotesByProUser,
      favoritedByUsername: favoritedByUsername,
    );

    final response = await _dio.get(url);
    final jsonObject = response.data;

    try {
      final quoteListPage = QuoteListPageRM.fromJson(jsonObject);
      return quoteListPage;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      switch (errorCode) {
        case 20:
          throw UserSessionNotFoundFavQsException();
        case 24:
          throw ProUserRequiredFavQsException();
        case 30:
          throw UserNotFoundFavQsException();
        case 40:
          throw QuoteNotFoundFavQsException();
        case 50:
          throw AuthorNotFoundFavQsException();
        case 60:
          throw TagNotFoundFavQsException();
        default:
          break;
      }
      rethrow;
    }
  }

  Future<QuoteRM> getQuote(int quoteId) async {
    final url = _quotesUrlBuilder.buildGetQuoteUrl(quoteId);
    final response = await _dio.get(url);
    final jsonObject = response.data;

    try {
      final quote = QuoteRM.fromJson(jsonObject);
      return quote;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      if (errorCode == 40) {
        throw QuoteNotFoundFavQsException();
      }
      rethrow;
    }
  }

  Future<QuoteRM> favoriteQuote(int quoteId) {
    final url = _quotesUrlBuilder.buildFavoriteQuoteUrl(quoteId);
    return _performQuoteAction(url);
  }

  Future<QuoteRM> unfavoriteQuote(int quoteId) {
    final url = _quotesUrlBuilder.buildUnfavoriteQuoteUrl(quoteId);
    return _performQuoteAction(url);
  }

  Future<QuoteRM> upvoteQuote(int quoteId) {
    final url = _quotesUrlBuilder.buildUpvoteQuoteUrl(quoteId);
    return _performQuoteAction(url);
  }

  Future<QuoteRM> downvoteQuote(int quoteId) {
    final url = _quotesUrlBuilder.buildDownvoteQuoteUrl(quoteId);
    return _performQuoteAction(url);
  }

  Future<QuoteRM> clearvoteOnQuote(int quoteId) {
    final url = _quotesUrlBuilder.buildClearvoteQuoteUrl(quoteId);
    return _performQuoteAction(url);
  }

  Future<QuoteRM> addPersonalTagsToQuote(
    int quoteId,
    List<String>? personalTags,
  ) async {
    final url = _quotesUrlBuilder.buildAddPersonalTagToQuoteUrl(quoteId);
    final selectedQuote = await getQuote(quoteId);
    final existingTags = selectedQuote.userDetails?.personalTags;
    final List<String> updatedTags = [
      ...existingTags ?? [],
      ...personalTags ?? []
    ];
    final requestJsonBody = PersonalTagsRM(personalTags: updatedTags).toJson();

    final response = await _dio.put(url, data: requestJsonBody);
    final jsonObject = response.data;

    try {
      final quote = QuoteRM.fromJson(jsonObject);
      return quote;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      if (errorCode == 20) {
        throw UserSessionNotFoundFavQsException();
      } else if (errorCode == 40) {
        throw QuoteNotFoundFavQsException();
      }
      //rethrow for other unhandled exceptions
      rethrow;
    }
  }

  Future<QuoteRM> hideQuote(int quoteId) {
    final url = _quotesUrlBuilder.buildHideQuoteUrl(quoteId);
    return _performQuoteAction(url);
  }

  Future<QuoteRM> unhideQuote(int quoteId) {
    final url = _quotesUrlBuilder.buildUnhideQuoteUrl(quoteId);
    return _performQuoteAction(url);
  }

  Future<QuoteRM> addQuote(String author, String body) async {
    final url = _quotesUrlBuilder.buildAddQuoteOrDialogueUrl();
    final requestJsonBody = QuoteRequestRM(
      author: author,
      body: body,
    ).toJson();
    final response = await _dio.post(url, data: requestJsonBody);
    final jsonObject = response.data;

    try {
      final quote = QuoteRM.fromJson(jsonObject);
      return quote;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      switch (errorCode) {
        case 20:
          throw UserSessionNotFoundFavQsException();
        case 42:
          throw CouldNotCreateQuoteFavQsException();
        default:
          break;
      }
      rethrow;
    }
  }

  Future<QuoteRM> addDialogue(
    List<DialogueLineRequestRM>? lines, {
    String? source,
    String? context,
    List<String>? tags,
  }) async {
    final url = _quotesUrlBuilder.buildAddQuoteOrDialogueUrl();
    final requestJsonBody = QuoteRequestRM(
      dialogueLines: lines,
      source: source,
      context: context,
      //TODO Compare the value for tags in adding a dialogue and normal quote JSON
      tags: tags,
    ).toJson();
    final response = await _dio.post(url, data: requestJsonBody);
    final jsonObject = response.data;

    try {
      final quote = QuoteRM.fromJson(jsonObject);
      return quote;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      switch (errorCode) {
        case 20:
          throw UserSessionNotFoundFavQsException();
        case 42:
          throw CouldNotCreateQuoteFavQsException();
        default:
          break;
      }
      rethrow;
    }
  }

  Future<QuoteRM> updateQuote(
    int quoteId, {
    String? author,
    String? body,
  }) async {
    final url = _quotesUrlBuilder.buildUpdateQuoteOrDialogueUrl(quoteId);
    final requestJsonBody = QuoteRequestRM(
      author: author,
      body: body,
    ).toJson();
    final response = await _dio.put(url, data: requestJsonBody);
    final jsonObject = response.data;

    try {
      final quote = QuoteRM.fromJson(jsonObject);
      return quote;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      switch (errorCode) {
        case 24:
          throw ProUserRequiredFavQsException();
        case 40:
          throw QuoteNotFoundFavQsException();
        default:
          break;
      }
      rethrow;
    }
  }

  Future<QuoteRM> updateDialogue(
    int quoteId,
    List<DialogueLineRequestRM> lines, {
    String? source,
    String? context,
    List<String>? tags,
  }) async {
    final url = _quotesUrlBuilder.buildUpdateQuoteOrDialogueUrl(quoteId);
    final requestJsonBody = DialogueRequestRM(
      lines: lines,
      source: source,
      context: context,
      tags: tags.toString(),
    ).toJson();
    final response = await _dio.put(url, data: requestJsonBody);
    final jsonObject = response.data;

    try {
      final quote = QuoteRM.fromJson(jsonObject);
      return quote;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      switch (errorCode) {
        case 24:
          throw ProUserRequiredFavQsException();
        case 40:
          throw QuoteNotFoundFavQsException();
        default:
          break;
      }
      rethrow;
    }
  }

  Future<QuoteRM> makeQuotePublic(int quoteId) {
    final url = _quotesUrlBuilder.buildMakeQuotePublicUrl(quoteId);
    return _performQuoteAction(url);
  }

  Future<void> deleteQuote(int quoteId) async {
    final url = _quotesUrlBuilder.buildDeleteQuoteUrl(quoteId);
    final response = await _dio.delete(url);
    final statusCode = response.statusCode;
    final statusMessage = response.statusMessage;

    try {
      if (statusCode == 200 && statusMessage!.toUpperCase() == 'OK') {
        return;
      }
    } catch (error) {
      switch (statusCode) {
        case 40:
          throw QuoteNotFoundFavQsException();
        case 404:
          throw Error404NotFoundFavQsException();
        case 500:
          throw Error500InternalServerErrorFavQsException();
        default:
          break;
      }
    }
  }

  //Helper function to submit HTTP PUT requests to perform a given
  // action on a quote object.
  Future<QuoteRM> _performQuoteAction(String url) async {
    final response = await _dio.put(url);
    final jsonObject = response.data;

    try {
      final quote = QuoteRM.fromJson(jsonObject);
      return quote;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      switch (errorCode) {
        case 20:
          throw UserSessionNotFoundFavQsException();
        case 24:
          throw ProUserRequiredFavQsException();
        case 40:
          throw QuoteNotFoundFavQsException();
        case 41:
          throw CannotUnfavPrivateQuotesFavQsException();
        default:
          break;
      }
      rethrow;
    }
  }
}
