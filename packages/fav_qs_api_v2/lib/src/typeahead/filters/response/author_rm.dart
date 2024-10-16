import 'package:json_annotation/json_annotation.dart';
import './filter_details_rm.dart';

part 'author_rm.g.dart';

@JsonSerializable(createToJson: false)
class AuthorRM {
  const AuthorRM({
    required this.details,
  });

  final FilterDetailsRM details;

  static const fromJson = _$AuthorRMFromJson;
}
