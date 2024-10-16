import 'package:dio/dio.dart';

import 'package:fav_qs_api_v2/src/dio_extensions.dart';
import 'package:fav_qs_api_v2/src/fav_qs_api_v2_exceptions.dart';
import 'package:fav_qs_api_v2/src/session/session_url_builder.dart';
import 'package:fav_qs_api_v2/src/session/models/session_models.dart';

class SessionApiSection {
  static const _errorCodeJsonKey = 'error_code';
  static const _message = 'message';
  SessionApiSection({
    this.userSessionTokenSupplier,
    Dio? dio,
    SessionUrlBuilder? sessionUrlBuilder,
  })  : _dio = dio ?? Dio(),
        _sessionUrlBuilder = sessionUrlBuilder ?? const SessionUrlBuilder() {
    _dio.setUpAuthHeaders(userSessionTokenSupplier);
    _dio.interceptors.add(LogInterceptor(responseBody: false));
  }

  final UserSessionTokenSupplier? userSessionTokenSupplier;
  final Dio _dio;
  final SessionUrlBuilder _sessionUrlBuilder;

  Future<UserRM> signIn(String username, String password) async {
    final url = _sessionUrlBuilder.buildSignInUrl();
    final requestJsonBody = UserRequestRM(
        userCredentials: UserCredentialsRequestRM(
      username: username,
      password: password,
    )).toJson();

    final response = await _dio.post(url, data: requestJsonBody);
    final jsonObject = response.data;

    try {
      final user = UserRM.fromJson(jsonObject);
      return user;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      switch (errorCode) {
        case 21:
          throw InvalidUsernameOrPasswordFavQsException();
        case 22:
          throw UsernameInactiveFavQsException();
        case 23:
          throw UsernameOrPasswordIsMissingFavQsException();
        default:
          break;
      }
      rethrow;
    }
  }

  Future<void> signOut() async {
    final url = _sessionUrlBuilder.buildSignOutUrl();
    final response = await _dio.delete(url);
    final jsonObject = response.data;
    final String message = jsonObject[_message];

    if (message.toLowerCase().contains('logged out')) {
      return;
    } else {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      if (errorCode == 20) {
        throw UserSessionNotFoundFavQsException();
      }
    }
  }
}
