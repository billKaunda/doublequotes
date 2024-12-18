import 'package:fav_qs_api_v2/fav_qs_api_v2.dart';
import 'package:domain_models/domain_models.dart';

extension AccountDetailsRMToDomain on AccountDetailsRM {
  AccountDetails toDomainModel() {
    return AccountDetails(
      email: email,
      privateFavoritesCount: privateFavoritesCount,
      proExpiration: proExpiration,
    );
  }
}

extension UserRMToDomain on UserRM {
  User toDomainModel() {
    return User(
      username: username,
      picUrl: picUrl,
      publicFavoritesCount: publicFavoritesCount,
      followers: followers,
      following: following,
      isProUser: isProUser,
      accountDetails: accountDetails!.toDomainModel(),
    );
  }
}

extension UserSessionRMToDomain on UserSessionRM {
  UserCredentials toDomainModel() {
    return UserCredentials(
      username: userCredentials.username,
      email: userCredentials.email,
    );
  }
}

extension FilterDetailsRMToDomain on FilterDetailsRM {
  FilterDetails toDomainModel() {
    return FilterDetails(
      count: count,
      permalink: permalink,
      name: name,
    );
  }
}

extension TypeahedRMToDomain on TypeaheadRM {
  Typeahead toDomainModel() {
    return Typeahead(
      authors: authors!.map((author) => author.toDomainModel()).toList(),
      users: users!.map((user) => user.toDomainModel()).toList(),
      tags: tags!.map((tag) => tag.toDomainModel()).toList(),
    );
  }
}
