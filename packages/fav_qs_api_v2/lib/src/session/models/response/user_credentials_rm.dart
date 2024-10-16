import 'package:json_annotation/json_annotation.dart';

part 'user_credentials_rm.g.dart';

@JsonSerializable(createToJson: false)
class UserCredentialsRM {
  UserCredentialsRM({
    required this.username,
    required this.email,
  });

  @JsonKey(name: 'login')
  final String? username;

  @JsonKey(name: 'email')
  final String? email;

  static const fromJson = _$UserCredentialsRMFromJson;
}
