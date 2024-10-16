import 'package:json_annotation/json_annotation.dart';
import './filter_details_rm.dart';

part 'user_rm.g.dart';

@JsonSerializable(createToJson: false)
class UserRM {
  const UserRM({
    required this.details,
  });

  final FilterDetailsRM details;

  static const fromJson = _$UserRMFromJson;
}