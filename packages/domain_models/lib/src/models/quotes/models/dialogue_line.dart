import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class DialogueLine extends Equatable {
  DialogueLine({
    required this.author,
    required this.body,
  }) : timestamp = DateTime.now();

  final String? author;

  final String? body;

  final DateTime timestamp;

  @override
  List<Object?> get props => [
        author,
        body,
        timestamp,
      ];

  //Format how the timestamp is displayed
  String get formattedTimestamp {
    return DateFormat('hh:mm a').format(timestamp); // e.g '11:59 AM'
  }
}
