import 'package:hive_local_storage/hive_local_storage.dart';

part 'dialogue_line_cm.g.dart';

@HiveType(typeId: 6)
class DialogueLineCM {
  const DialogueLineCM({
    required this.author,
    required this.body,
  });

  @HiveField(0)
  final String? author;

  @HiveField(1)
  final String? body;
}
