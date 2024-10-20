import 'package:equatable/equatable.dart';

class FollowingItem extends Equatable {
  const FollowingItem({
    required this.followingType,
    this.followingId,
    this.followingValue,
  });

  final String followingType;

  final String? followingId;

  final String? followingValue;

  @override
  List<Object?> get props => [
        followingType,
        followingId,
        followingValue,
      ];
}
