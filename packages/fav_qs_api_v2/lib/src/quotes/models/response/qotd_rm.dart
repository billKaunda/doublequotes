import 'package:json_annotation/json_annotation.dart';
import './quote_rm.dart';

part 'qotd_rm.g.dart';

@JsonSerializable(createToJson: false)
class QotdRM {
  const QotdRM({
    required this.date,
    required this.quote,
  });

  @JsonKey(name: 'qotd_date')
  final String date;

  @JsonKey(name: 'quote')
  final QuoteRM quote;

  static const fromJson = _$QotdRMFromJson;
}
