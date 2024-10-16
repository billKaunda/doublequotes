import 'package:json_annotation/json_annotation.dart';

part 'filter_details_rm.g.dart';

@JsonSerializable(createToJson: false)
class FilterDetailsRM {
  const FilterDetailsRM({
    this.count,
    this.permalink,
    this.name,
  });

  @JsonKey(name: 'count')
  final int? count;

  @JsonKey(name: 'permalink')
  final String? permalink;

  @JsonKey(name: 'name')
  final String? name;

  static const fromJson = _$FilterDetailsRMFromJson;
}
