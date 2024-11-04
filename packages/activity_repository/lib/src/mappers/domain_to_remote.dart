import 'package:domain_models/domain_models.dart';

extension TypeLookupDomainToRM on TypeLookup {
  String toRemoteModel() {
    switch (this) {
      case TypeLookup.author:
        return 'author';
      case TypeLookup.tag:
        return 'tag';
      case TypeLookup.user:
        return 'user';
    }
  }
}
