import 'package:hive/hive.dart';

part 'dialogue_lines_cm.g.dart';

@HiveType(typeId: 8)
class DialogueLinesCM {
  const DialogueLinesCM({
    required this.author,
    required this.body,
  });

  @HiveField(0)
  final String? author;

  @HiveField(1)
  final String? body;
}
