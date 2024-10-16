import 'package:json_annotation/json_annotation.dart';
import 'tag_request_rm.dart';
import 'user_details_request_rm.dart';
import 'dialogue_lines_request_rm.dart';

part 'quote_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class QuoteRequestRM {
  const QuoteRequestRM({
    this.quoteId,
    this.favoritesCount,
    this.enableDialogue,
    this.isFavorite,
    this.tags,
    this.quoteUrl,
    this.upvotesCount,
    this.downvotesCount,
    this.author,
    this.authorPermalink,
    this.body,
    this.isPrivate,
    this.userDetails,
    this.dialogueLines,
    this.source,
    this.context,
  });

  @JsonKey(name: 'id')
  final int? quoteId;

  @JsonKey(name: 'favorites_count', defaultValue: 0)
  final int? favoritesCount;

  @JsonKey(name: 'dialogue')
  final bool? enableDialogue;

  @JsonKey(name: 'favorite')
  final bool? isFavorite;

  @JsonKey(name: 'tags')
  final List<TagRequestRM>? tags;

  @JsonKey(name: 'url')
  final String? quoteUrl;

  @JsonKey(name: 'upvotes_count', defaultValue: 0)
  final int? upvotesCount;

  @JsonKey(name: 'downvotes_count', defaultValue: 0)
  final int? downvotesCount;

  @JsonKey(name: 'author')
  final String? author;

  @JsonKey(name: 'author_permalink')
  final String? authorPermalink;

  @JsonKey(name: 'body')
  final String? body;

  @JsonKey(name: 'private')
  final bool? isPrivate;

  @JsonKey(name: 'user_details')
  final UserDetailsRequestRM? userDetails;

  @JsonKey(name: 'lines')
  final List<DialogueLinesRequestRM>? dialogueLines;

  @JsonKey(name: 'source')
  final String? source;

  @JsonKey(name: 'context')
  final String? context;

  Map<String, dynamic> toJson() => _$QuoteRequestRMToJson(this);
}
