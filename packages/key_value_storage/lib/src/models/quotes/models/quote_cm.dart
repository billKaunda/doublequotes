import 'package:hive/hive.dart';
import './user_details_cm.dart';
import './dialogue_lines_cm.dart';

part 'quote_cm.g.dart';

@HiveType(typeId: 9)
class QuoteCM {
  const QuoteCM({
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

  @HiveField(0)
  final int quoteId;

  @HiveField(1)
  final int? favoritesCount;

  @HiveField(2)
  final bool? enableDialogue;

  @HiveField(3)
  final bool? isFavorite;

  @HiveField(4)
  final List<String>? tags;

  @HiveField(5)
  final String? quoteUrl;

  @HiveField(6)
  final int? upvotesCount;

  @HiveField(7)
  final int? downvotesCount;

  @HiveField(8)
  final String? author;

  @HiveField(9)
  final String? authorPermalink;

  @HiveField(10)
  final String? body;

  @HiveField(11)
  final bool? isPrivate;

  @HiveField(12)
  final UserDetailsCM? userDetails;

  @HiveField(13)
  final List<DialogueLinesCM>? dialogueLines;

  @HiveField(14)
  final String? source;

  @HiveField(15)
  final String? context;

}
