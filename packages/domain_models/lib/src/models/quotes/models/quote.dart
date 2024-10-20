import 'package:equatable/equatable.dart';
import './user_details.dart';
import './dialogue_lines.dart';

class Quote extends Equatable {
  const Quote({
    required this.quoteId,
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

  final int quoteId;

  final int? favoritesCount;

  final bool? enableDialogue;

  final bool? isFavorite;

  final List<String>? tags;

  final String? quoteUrl;

  final int? upvotesCount;

  final int? downvotesCount;

  final String? author;

  final String? authorPermalink;

  final String? body;

  final bool? isPrivate;

  final UserDetails? userDetails;

  final List<DialogueLines>? dialogueLines;

  final String? source;

  final String? context;

  @override
  List<Object?> get props => [
    quoteId,
    favoritesCount,
    enableDialogue,
    isFavorite,
    tags,
    quoteUrl,
    upvotesCount,
    downvotesCount,
    author,
    authorPermalink,
    body,
    isPrivate,
    userDetails,
    dialogueLines,
    source,
    context,
  ];
}
