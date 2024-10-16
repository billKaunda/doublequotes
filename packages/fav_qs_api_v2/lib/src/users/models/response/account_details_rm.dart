import 'package:json_annotation/json_annotation.dart';

part 'account_details_rm.g.dart';

@JsonSerializable(createToJson: false)
class AccountDetailsRM {
  const AccountDetailsRM({
    required this.email,
    this.privateFavoritesCount,
    this.proExpiration,
  });

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'private_favorites_count')
  final int? privateFavoritesCount;

  @JsonKey(name: 'pro_expiration')
  final String? proExpiration;

  static const fromJson = _$AccountDetailsRMFromJson;
}
