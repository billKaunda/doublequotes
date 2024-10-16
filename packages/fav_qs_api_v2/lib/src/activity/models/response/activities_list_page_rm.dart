import 'package:json_annotation/json_annotation.dart';
import './activity_rm.dart';

part 'activities_list_page_rm.g.dart';

@JsonSerializable(createToJson: false)
class ActivitiesListPageRM {
  const ActivitiesListPageRM({
    this.activities,
  });

  @JsonKey(name: 'activities')
  final List<ActivityRM>? activities;

  static const fromJson = _$ActivitiesListPageRMFromJson;
}
