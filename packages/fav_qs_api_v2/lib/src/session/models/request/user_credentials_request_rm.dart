import 'package:json_annotation/json_annotation.dart';

part 'user_credentials_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class UserCredentialsRequestRM{
  const UserCredentialsRequestRM({
    required this.username,
    required this.password,
  });

  @JsonKey(name: 'login')
  final String username;

  @JsonKey(name: 'password')
  final String password;

  Map<String, dynamic> toJson() => _$UserCredentialsRequestRMToJson(this);
}