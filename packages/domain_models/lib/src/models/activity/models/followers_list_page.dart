import 'package:equatable/equatable.dart';

class FollowersListPage extends Equatable {
  const FollowersListPage({
    this.page,
    this.isLastPage,
    this.users,
    this.authors,
    this.tags,
  });

  final int? page;

  final bool? isLastPage;

  final List<String>? users;

  final List<String>? authors;

  final List<String>? tags;

  @override
  List<Object?> get props => [
        page,
        isLastPage,
        users,
        authors,
        tags,
      ];
}
