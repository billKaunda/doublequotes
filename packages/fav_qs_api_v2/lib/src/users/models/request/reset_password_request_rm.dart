import 'package:fav_qs_api_v2/src/users/models/request/user_request_rm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class ResetPasswordRequestRM {
  const ResetPasswordRequestRM({
    required this.user,
  });

  @JsonKey(name: 'user')
  final UserRequestRM user;

  Map<String, dynamic> toJson() => _$ResetPasswordRequestRMToJson(this);
}
