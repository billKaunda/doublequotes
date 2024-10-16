// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities_list_page_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivitiesListPageRM _$ActivitiesListPageRMFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'ActivitiesListPageRM',
      json,
      ($checkedConvert) {
        final val = ActivitiesListPageRM(
          activities: $checkedConvert(
              'activities',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => ActivityRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );
