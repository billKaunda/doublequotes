import 'package:json_annotation/json_annotation.dart';
import './user_request_rm.dart';

part 'sign_up_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class SignUpRequestRM {
  const SignUpRequestRM({
    required this.user,
  });

  @JsonKey(name: 'user')
  final UserRequestRM user;

  Map<String, dynamic> toJson() => _$SignUpRequestRMToJson(this);
}
