import 'package:equatable/equatable.dart';
import './activity.dart';

class ActivitiesListPage extends Equatable {
  const ActivitiesListPage({
    this.activities,
  });

  final List<Activity>? activities;

  @override
  List<Object?> get props => [
        activities,
      ];
}
