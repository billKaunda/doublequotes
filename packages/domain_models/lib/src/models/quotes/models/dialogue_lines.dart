import 'package:equatable/equatable.dart';

class DialogueLines extends Equatable {
  const DialogueLines({
    required this.author,
    required this.body,
  });

  final String? author;

  final String? body;

  @override
  List<Object?> get props => [
        author,
        body,
      ];
}
