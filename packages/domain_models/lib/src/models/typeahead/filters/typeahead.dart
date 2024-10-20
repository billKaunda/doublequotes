import 'package:equatable/equatable.dart';
import './filter_details.dart';

class Typeahead extends Equatable {
  const Typeahead({
    this.authors,
    this.users,
    this.tags,
  });

  final List<FilterDetails>? authors;

  final List<FilterDetails>? users;

  final List<FilterDetails>? tags;

  @override
  List<Object?> get props => [
        authors,
        users,
        tags,
      ];
}
