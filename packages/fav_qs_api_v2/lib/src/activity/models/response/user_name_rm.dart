import 'package:json_annotation/json_annotation.dart';

part 'user_name_rm.g.dart';

@JsonSerializable(createToJson: false)
class UserNameRM {
  const UserNameRM({
    required this.name,
  });

  final String name;

  static const fromJson = _$UserNameRMFromJson;
}