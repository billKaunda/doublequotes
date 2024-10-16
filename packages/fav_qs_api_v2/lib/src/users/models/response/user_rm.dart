import 'package:json_annotation/json_annotation.dart';
import './account_details_rm.dart';

part 'user_rm.g.dart';

@JsonSerializable(createToJson: false)
class UserRM {
  const UserRM({
    required this.username,
    this.picUrl,
    this.publicFavoritesCount,
    this.followers,
    this.following,
    this.isProUser,
    this.accountDetails,
  });

  @JsonKey(name: 'login')
  final String username;

  @JsonKey(name: 'pic_url')
  final String? picUrl;

  @JsonKey(name: 'public_favorites_count')
  final int? publicFavoritesCount;

  @JsonKey(name: 'followers')
  final int? followers;

  @JsonKey(name: 'following')
  final int? following;

  @JsonKey(name: 'pro')
  final bool? isProUser;

  @JsonKey(name: 'account_details')
  final AccountDetailsRM? accountDetails;

  static const fromJson = _$UserRMFromJson;
}
