import 'package:json_annotation/json_annotation.dart';
import './user_credentials_rm.dart';

part 'user_rm.g.dart';

@JsonSerializable(createToJson: false)
class UserRM {
  const UserRM({
    required this.userToken,
    required this.userCredentials,
  });

  @JsonKey(name: 'User-Token')
  final String userToken;

  final UserCredentialsRM userCredentials;

  static const fromJson = _$UserRMFromJson;
}
