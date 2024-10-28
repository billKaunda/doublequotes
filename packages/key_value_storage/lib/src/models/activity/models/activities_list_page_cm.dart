import 'package:hive_local_storage/hive_local_storage.dart';
import 'activity_cm.dart';

part 'activities_list_page_cm.g.dart';

@HiveType(typeId: 2)
class ActivitiesListPageCM {
  const ActivitiesListPageCM({
    this.activities,
  });

  @HiveField(0)
  final List<ActivityCM>? activities;
}
