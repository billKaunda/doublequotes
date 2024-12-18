import 'package:equatable/equatable.dart';
import './account_details.dart';

class User extends Equatable {
  const User({
    required this.username,
    this.picUrl,
    this.publicFavoritesCount,
    this.followers,
    this.following,
    this.isProUser,
    this.accountDetails,
  });

  final String username;

  final String? picUrl;

  final int? publicFavoritesCount;

  final int? followers;

  final int? following;

  final bool? isProUser;

  final AccountDetails? accountDetails;

  @override
  List<Object?> get props => [
        username,
        picUrl,
        publicFavoritesCount,
        followers,
        following,
        isProUser,
        accountDetails,
      ];
}
