import 'package:json_annotation/json_annotation.dart';
import 'user_credentials_request_rm.dart';

part 'user_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class UserRequestRM {
  const UserRequestRM({
    required this.userCredentials,
  });

  @JsonKey(name: 'user')
  final UserCredentialsRequestRM userCredentials;

  Map<String, dynamic> toJson() => _$UserRequestRMToJson(this);
}
