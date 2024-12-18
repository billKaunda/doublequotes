import 'package:meta/meta.dart';

import 'package:dio/dio.dart';
import 'package:fav_qs_api_v2/src/extensions.dart';
import 'package:fav_qs_api_v2/src/fav_qs_api_v2_exceptions.dart';
import './models/users_models.dart';

import './users_url_builder.dart';

class UsersApiSection {
  static const _errorCodeJsonKey = 'error_code';
  static const _message = 'message';

  UsersApiSection({
    this.userSessionTokenSupplier,
    @visibleForTesting Dio? dio,
    @visibleForTesting UsersUrlBuilder? usersUrlBuilder,
  })  : _dio = dio ?? Dio(),
        _usersUrlBuilder = usersUrlBuilder ?? const UsersUrlBuilder() {
    _dio.setUpAuthHeaders(userSessionTokenSupplier);
    _dio.interceptors.add(LogInterceptor(responseBody: false));
  }

  final UserSessionTokenSupplier? userSessionTokenSupplier;
  final Dio _dio;
  final UsersUrlBuilder _usersUrlBuilder;

  Future<String> signUp(
    String username,
    String email,
    String password,
  ) async {
    final url = _usersUrlBuilder.buildSignUpUrl();
    final requestJsonBody = SignUpRequestRM(
      user: UserRequestRM(
        username: username,
        email: email,
        password: password,
      ),
    ).toJson();

    final response = await _dio.post(url, data: requestJsonBody);
    final jsonObject = response.data;

    try {
      return jsonObject['User-Token'];
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      if (errorCode == 32) {
        final String message = jsonObject[_message];
        _userValidationErrorsChecker(message);
      } else if (errorCode == 31) {
        throw UserSessionAlreadyPresentFavQsException();
      }
      rethrow;
    }
  }

  Future<UserRM> getUser() async {
    final url = _usersUrlBuilder.buildGetUserUrl();
    final response = await _dio.get(url);
    final jsonObject = response.data;

    try {
      final user = UserRM.fromJson(jsonObject);
      return user;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      switch (errorCode) {
        case 20:
          throw UserSessionNotFoundFavQsException();
        case 22:
          throw UsernameInactiveFavQsException();
        case 30:
          throw UserNotFoundFavQsException();
        default:
          break;
      }
      rethrow;
    }
  }

  Future<void> updateUser({
    String? username,
    String? email,
    String? password,
    String? twitterUsername,
    String? facebookUsername,
    String? pic,
    bool? enableProfanityFilter,
  }) async {
    final url = _usersUrlBuilder.buildUpdateUserUrl();
    final requestJsonBody = UpdateUserRequestRM(
        user: UserRequestRM(
      username: username,
      email: email,
      password: password,
      twitterUsername: twitterUsername,
      facebookUsername: facebookUsername,
      pic: pic,
      enableProfanityFilter: enableProfanityFilter,
    )).toJson();

    final response = await _dio.put(url, data: requestJsonBody);
    final jsonObject = response.data;
    final int errorCode = jsonObject[_errorCodeJsonKey];
    final String message = jsonObject[_message];

    if (message.toLowerCase().contains('successfully updated')) {
      return;
    } else if (errorCode == 32) {
      _userValidationErrorsChecker(message);
    }
  }

  Future<void> forgotPasswordRequest(String email) async {
    final url = _usersUrlBuilder.buildForgotPasswordUrl();
    final requestJsonBody = ForgotPasswordRequestRM(
      user: UserRequestRM(
        email: email,
      ),
    ).toJson();

    final response = await _dio.post(url, data: requestJsonBody);
    final jsonObject = response.data;
    final String message = jsonObject[_message];

    if (message.toLowerCase().contains('emailed')) {
      return;
    } else {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      if (errorCode == 30) {
        throw UserNotFoundFavQsException();
      }
    }
  }

  Future<void> resetPassword(
    String email,
    String resetPasswordToken,
  ) async {
    final url = _usersUrlBuilder.buildResetPasswordUrl();
    final requestJsonBody = ResetPasswordRequestRM(
      user: UserRequestRM(
        email: email,
        resetPasswordToken: resetPasswordToken,
      ),
    ).toJson();

    final response = await _dio.post(url, data: requestJsonBody);
    final jsonObject = response.data;
    final String message = jsonObject[_message];

    if (message.toLowerCase().contains('successfully updated')) {
      return;
    } else {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      if (errorCode == 33) {
        throw InvalidPasswordResetTokenFavQsException();
      }
    }
  }

  //TODO Open the link in a web view for one to purchase a 1-yr FavQs Pro sub
  Future<void> becomeProUser() async {
    final url = _usersUrlBuilder.buildBecomeProUserUrl();
  }

  void _userValidationErrorsChecker(String message) {
    final lowerCaseMessage = message.toLowerCase();

    switch (_getUserValidationErrorType(lowerCaseMessage)) {
      case 'login':
        throw UsernameAlreadyTakenFavQsException();
      case 'email':
        throw EmailAlreadyRegisteredFavQsException();
      case 'password':
        throw InvalidPasswordFavQsException();
      case 'pic':
        throw PicNotFoundFavQsException();
      case 'profanity_filter':
        throw ProfanityFilterToggleErrorFavQsException();
      default:
        break;
    }
  }

  String _getUserValidationErrorType(String message) {
    if (message.contains('login')) {
      return 'login';
    } else if (message.contains('email')) {
      return 'email';
    } else if (message.contains('password')) {
      return 'password';
    } else if (message.contains('pic')) {
      return 'pic';
    } else if (message.contains('profanity_filter')) {
      return 'profanity_filter';
    }
    //Default case
    return 'unknown validation error';
  }
}
