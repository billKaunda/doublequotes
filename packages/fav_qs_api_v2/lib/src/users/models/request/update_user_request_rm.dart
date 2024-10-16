import 'package:json_annotation/json_annotation.dart';
import './user_request_rm.dart';

part 'update_user_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class UpdateUserRequestRM {
  const UpdateUserRequestRM({
    required this.user,
  });

  @JsonKey(name: 'user')
  final UserRequestRM user;

  Map<String, dynamic> toJson() => _$UpdateUserRequestRMToJson(this);
}
