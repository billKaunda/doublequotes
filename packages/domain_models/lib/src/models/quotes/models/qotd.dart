import 'package:equatable/equatable.dart';
import './quote.dart';

class Qotd extends Equatable {
  const Qotd({
    this.date,
    this.quote,
  });

  final String? date;

  final Quote? quote;

  @override
  List<Object?> get props => [
        date,
        quote,
      ];
}
