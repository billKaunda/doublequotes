import 'package:json_annotation/json_annotation.dart';
import './account_details_request_rm.dart';

part 'user_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class UserRequestRM {
  const UserRequestRM({
    this.username,
    this.email,
    this.password,
    this.twitterUsername,
    this.facebookUsername,
    this.pic,
    this.picUrl,
    this.enableProfanityFilter,
    this.publicFavoritesCount,
    this.followers,
    this.following,
    this.isProUser,
    this.resetPasswordToken,
    this.accountDetails,
  });

  @JsonKey(name: 'username')
  final String? username;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'password')
  final String? password;

  @JsonKey(name: 'twitter_username')
  final String? twitterUsername;

  @JsonKey(name: 'facebook_username')
  final String? facebookUsername;

  @JsonKey(name: 'pic')
  final String? pic;

  @JsonKey(name: 'pic_url')
  final String? picUrl;

  @JsonKey(name: 'profanity_filter')
  final bool? enableProfanityFilter;

  @JsonKey(name: 'public_favorites_count')
  final int? publicFavoritesCount;

  @JsonKey(name: 'followers')
  final int? followers;

  @JsonKey(name: 'following')
  final int? following;

  @JsonKey(name: 'pro')
  final bool? isProUser;

  @JsonKey(name: 'reset_password_token')
  final String? resetPasswordToken;

  @JsonKey(name: 'account_details')
  final AccountDetailsRequestRM? accountDetails;

  Map<String, dynamic> toJson() => _$UserRequestRMToJson(this);
}
