import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _tokenKey = 'double-quotes-token';
  static const _emailKey = 'double-quotes-email';
  static const _usernameKey = 'double-quotes-username';
  static const _passwordKey = 'double-quotes-password';
  static const _twitterUsernameKey = 'double-quotes-twitter-username';
  static const _facebookUsernameKey = 'double-quotes-facebook-username';
  static const _picKey = 'double-quotes-pic';
  static const _profanityFilterKey = 'false';
  static const _privateFavoritesCountKey =
      'double-quotes-private-favorites-count';
  static const _proExpirationKey = 'double-quotes-pro-expiration-count';
  static const _picUrlKey = 'double-quotes-pic-url';
  static const _publicFavoritesCountKey =
      'double-quotes-public-favorites-count';
  static const _followersKey = 'double-quotes-followers-key';
  static const _followingKey = 'double-quotes-following-key';
  static const _isProUserKey = 'double-quotes-is-pro-user';

  const UserSecureStorage({
    FlutterSecureStorage? secureStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  Future<void> upsertUser({
    String? username,
    String? picUrl,
    int? publicFavoritesCount,
    int? followers,
    int? following,
    bool? isProUser,
  }) =>
      Future.wait([
        _secureStorage.write(key: _usernameKey, value: username),
        _secureStorage.write(key: _picUrlKey, value: picUrl),
        _secureStorage.write(
            key: _publicFavoritesCountKey,
            value: publicFavoritesCount.toString()),
        _secureStorage.write(key: _followersKey, value: followers.toString()),
        _secureStorage.write(key: _followingKey, value: following.toString()),
        _secureStorage.write(key: _isProUserKey, value: isProUser.toString()),
      ]);

  Future<void> upsertAccountDetails({
    String? email,
    int? privateFavoritesCount,
    String? proExpiration,
  }) =>
      Future.wait([
        _secureStorage.write(key: _emailKey, value: email),
        _secureStorage.write(
            key: _privateFavoritesCountKey,
            value: privateFavoritesCount.toString()),
        _secureStorage.write(key: _proExpirationKey, value: proExpiration),
      ]);

  Future<void> upsertUserInfo({
    required String username,
    required String email,
    String? token,
    String? password,
    String? twitterUsername,
    String? facebookUsername,
    String? pic,
    bool? enableProfanityFilter,
  }) =>
      Future.wait([
        _secureStorage.write(key: _usernameKey, value: username),
        _secureStorage.write(key: _emailKey, value: email),
        _secureStorage.write(key: _tokenKey, value: token),
        _secureStorage.write(key: _passwordKey, value: password),
        _secureStorage.write(key: _twitterUsernameKey, value: twitterUsername),
        _secureStorage.write(
            key: _facebookUsernameKey, value: facebookUsername),
        _secureStorage.write(key: _picKey, value: pic),
        _secureStorage.write(
            key: _profanityFilterKey, value: enableProfanityFilter.toString()),
      ]);

  Future<void> deleteUserInfo() => Future.wait([
        _secureStorage.delete(key: _tokenKey),
        _secureStorage.delete(key: _usernameKey),
        _secureStorage.delete(key: _emailKey),
      ]);

  Future<String?> getUsername() => _secureStorage.read(key: _usernameKey);

  Future<String?> getEmail() => _secureStorage.read(key: _emailKey);

  Future<String?> getToken() => _secureStorage.read(key: _tokenKey);
}
