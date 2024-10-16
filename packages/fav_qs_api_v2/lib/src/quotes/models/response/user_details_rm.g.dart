// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsRM _$UserDetailsRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserDetailsRM',
      json,
      ($checkedConvert) {
        final val = UserDetailsRM(
          isFavorite: $checkedConvert('favorite', (v) => v as bool?),
          isUpvoted: $checkedConvert('upvote', (v) => v as bool?),
          isDownvoted: $checkedConvert('downvote', (v) => v as bool?),
          isHidden: $checkedConvert('hidden', (v) => v as bool?),
          personalTags: $checkedConvert(
              'personal_tags',
              (v) => (v as List<dynamic>?)
                  ?.map(
                      (e) => PersonalTagRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'isFavorite': 'favorite',
        'isUpvoted': 'upvote',
        'isDownvoted': 'downvote',
        'isHidden': 'hidden',
        'personalTags': 'personal_tags'
      },
    );
