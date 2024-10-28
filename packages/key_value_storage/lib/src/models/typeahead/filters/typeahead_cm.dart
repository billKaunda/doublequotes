import 'package:hive_local_storage/hive_local_storage.dart';
import './filter_details_cm.dart';

part 'typeahead_cm.g.dart';

@HiveType(typeId: 13)
class TypeaheadCM {
  const TypeaheadCM({
    this.authors,
    this.users,
    this.tags,
  });

  @HiveField(0)
  final List<FilterDetailsCM>? authors;

  @HiveField(1)
  final List<FilterDetailsCM>? users;

  @HiveField(2)
  final List<FilterDetailsCM>? tags;

}
