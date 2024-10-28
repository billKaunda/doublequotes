import 'package:hive_local_storage/hive_local_storage.dart';

part 'filter_details_cm.g.dart';

@HiveType(typeId: 12)
class FilterDetailsCM {
  const FilterDetailsCM({
    this.count,
    this.permalink,
    this.name,
  });

  @HiveField(0)
  final int? count;

  @HiveField(1)
  final String? permalink;

  @HiveField(2)
  final String? name;
}
