import 'package:equatable/equatable.dart';

class AccountDetails extends Equatable {
  const AccountDetails({
    required this.email,
    this.privateFavoritesCount,
    this.proExpiration,
  });

  final String email;
  final int? privateFavoritesCount;
  final String? proExpiration;

  @override
  List<Object?> get props => [
        email,
        privateFavoritesCount,
        proExpiration,
      ];
}
