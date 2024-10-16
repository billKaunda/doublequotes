import 'package:json_annotation/json_annotation.dart';

part 'sign_up_rm.g.dart';

@JsonSerializable(createToJson: false)
class SignUpRM {
  const SignUpRM({
    required this.userToken,
    required this.username,
  });

  @JsonKey(name: 'User-Token')
  final String userToken;

  @JsonKey(name: 'login')
  final String username;

  static const fromJson = _$SignUpRMFromJson;
}
