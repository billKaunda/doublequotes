import 'package:json_annotation/json_annotation.dart';

part 'account_details_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class AccountDetailsRequestRM {
  const AccountDetailsRequestRM({
    this.email,
    this.privateFavoritesCount,
    this.proExpiration,
  });

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'private_favorites_count')
  final int? privateFavoritesCount;

  @JsonKey(name: 'pro_expiration')
  final String? proExpiration;

  Map<String, dynamic> toJson() => _$AccountDetailsRequestRMToJson(this);
}
