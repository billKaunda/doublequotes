import 'package:json_annotation/json_annotation.dart';

part 'user_details_rm.g.dart';

@JsonSerializable(createToJson: false)
class UserDetailsRM {
  const UserDetailsRM({
    this.isFavorite,
    this.isUpvoted,
    this.isDownvoted,
    this.isHidden,
    this.personalTags,
  });

  @JsonKey(name: 'favorite')
  final bool? isFavorite;

  @JsonKey(name: 'upvote')
  final bool? isUpvoted;

  @JsonKey(name: 'downvote')
  final bool? isDownvoted;

  @JsonKey(name: 'hidden')
  final bool? isHidden;

  @JsonKey(name: 'personal_tags')
  final List<String>? personalTags;

  static const fromJson = _$UserDetailsRMFromJson;
}
