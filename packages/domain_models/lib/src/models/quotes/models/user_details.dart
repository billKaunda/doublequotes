import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  const UserDetails({
    required this.isFavorite,
    required this.isUpvoted,
    required this.isDownvoted,
    this.isHidden,
    this.personalTags,
  });

  final bool isFavorite;

  final bool isUpvoted;

  final bool isDownvoted;

  final bool? isHidden;

  final List<String>? personalTags;

  @override
  List<Object?> get props => [
        isFavorite,
        isUpvoted,
        isDownvoted,
        isHidden,
        personalTags,
      ];
}
