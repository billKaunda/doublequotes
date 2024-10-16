import 'package:json_annotation/json_annotation.dart';
import './quote_rm.dart';

part 'qotd_rm.g.dart';

@JsonSerializable(createToJson: false)
class QotdRM {
  const QotdRM({
    required this.qotdDate,
    required this.quote,
  });

  @JsonKey(name: 'qotd_date')
  final String qotdDate;

  @JsonKey(name: 'quote')
  final QuoteRM quote;

  static const fromJson = _$QotdRMFromJson;
}
