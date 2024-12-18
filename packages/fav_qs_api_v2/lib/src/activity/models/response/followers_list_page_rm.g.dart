// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followers_list_page_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowersListPageRM _$FollowersListPageRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FollowersListPageRM',
      json,
      ($checkedConvert) {
        final val = FollowersListPageRM(
          page: $checkedConvert('page', (v) => (v as num?)?.toInt()),
          isLastPage: $checkedConvert('last_page', (v) => v as bool?),
          users: $checkedConvert('users',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          authors: $checkedConvert('authors',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          tags: $checkedConvert('tags',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
        );
        return val;
      },
      fieldKeyMap: const {'isLastPage': 'last_page'},
    );
