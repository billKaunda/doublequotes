import 'package:json_annotation/json_annotation.dart';

part 'user_details_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class UserDetailsRequestRM {
  const UserDetailsRequestRM({
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

  Map<String, dynamic> toJson() => _$UserDetailsRequestRMToJson(this);
}
