import 'package:fav_qs_api_v2/fav_qs_api_v2.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension FilterDetailsRMToCM on FilterDetailsRM {
  FilterDetailsCM toCacheModel() {
    return FilterDetailsCM(
      count: count,
      permalink: permalink,
      name: name,
    );
  }
}

extension TypeahedRMToCM on TypeaheadRM {
  TypeaheadCM toCacheModel() {
    return TypeaheadCM(
      authors: authors!.map((author) => author.toCacheModel()).toList(),
      users: users!.map((user) => user.toCacheModel()).toList(),
      tags: tags!.map((tag) => tag.toCacheModel()).toList(),
    );
  }
}
