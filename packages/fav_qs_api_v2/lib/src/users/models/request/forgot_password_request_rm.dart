import 'package:json_annotation/json_annotation.dart';
import './user_request_rm.dart';

part 'forgot_password_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class ForgotPasswordRequestRM {
  const ForgotPasswordRequestRM({
    required this.user,
  });

  @JsonKey(name: 'user')
  final UserRequestRM user;

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestRMToJson(this);
}
