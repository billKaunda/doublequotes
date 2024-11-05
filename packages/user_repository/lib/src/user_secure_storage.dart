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

  const UserSecureStorage({
    FlutterSecureStorage? secureStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

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
            key: _profanityFilterKey, value: enableProfanityFilter as String),
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
