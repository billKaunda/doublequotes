import 'package:json_annotation/json_annotation.dart';

part 'author_rm.g.dart';

@JsonSerializable(createToJson: false)
class AuthorRM {
  const AuthorRM({
    this.authorName,
  });

  final String? authorName;

  static const fromJson = _$AuthorRMFromJson;
}
