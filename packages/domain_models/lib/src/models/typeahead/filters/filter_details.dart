import 'package:equatable/equatable.dart';

class FilterDetails extends Equatable {
  const FilterDetails({
    this.count,
    this.permalink,
    this.name,
  });

  final int? count;

  final String? permalink;

  final String? name;

  @override
  List<Object?> get props => [
        count,
        permalink,
        name,
      ];
}
