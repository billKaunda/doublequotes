// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteRM _$QuoteRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'QuoteRM',
      json,
      ($checkedConvert) {
        final val = QuoteRM(
          quoteId: $checkedConvert('id', (v) => (v as num).toInt()),
          favoritesCount: $checkedConvert(
              'favorites_count', (v) => (v as num?)?.toInt() ?? 0),
          enableDialogue: $checkedConvert('dialogue', (v) => v as bool?),
          isFavorite: $checkedConvert('favorite', (v) => v as bool?),
          tags: $checkedConvert('tags',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          quoteUrl: $checkedConvert('url', (v) => v as String?),
          upvotesCount: $checkedConvert(
              'upvotes_count', (v) => (v as num?)?.toInt() ?? 0),
          downvotesCount: $checkedConvert(
              'downvotes_count', (v) => (v as num?)?.toInt() ?? 0),
          author: $checkedConvert('author', (v) => v as String?),
          authorPermalink:
              $checkedConvert('author_permalink', (v) => v as String?),
          body: $checkedConvert('body', (v) => v as String?),
          isPrivate: $checkedConvert('private', (v) => v as bool?),
          userDetails: $checkedConvert(
              'user_details',
              (v) => v == null
                  ? null
                  : UserDetailsRM.fromJson(v as Map<String, dynamic>)),
          dialogueLines: $checkedConvert(
              'lines',
              (v) => (v as List<dynamic>?)
                  ?.map(
                      (e) => DialogueLineRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
          source: $checkedConvert('source', (v) => v as String?),
          context: $checkedConvert('context', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'quoteId': 'id',
        'favoritesCount': 'favorites_count',
        'enableDialogue': 'dialogue',
        'isFavorite': 'favorite',
        'quoteUrl': 'url',
        'upvotesCount': 'upvotes_count',
        'downvotesCount': 'downvotes_count',
        'authorPermalink': 'author_permalink',
        'isPrivate': 'private',
        'userDetails': 'user_details',
        'dialogueLines': 'lines'
      },
    );
