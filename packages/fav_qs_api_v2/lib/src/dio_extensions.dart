import 'package:dio/dio.dart';

typedef UserSessionTokenSupplier = Future<String?> Function();

extension DioExtensions on Dio {
  static const _baseUrl = 'https://favqs.com/api';
  static const _appTokenEnvironmentVariableKey = 'fav-qs-app-token';

  void setUpAuthHeaders(UserSessionTokenSupplier? userSessionTokenSupplier) {
    final appToken =
        const String.fromEnvironment(_appTokenEnvironmentVariableKey);

    options = BaseOptions(
      headers: {
        'Authorization': 'Token token=$appToken',
        'Accept': 'application/vnd.favqs.v2+json',
      },
      contentType: 'application/json',
    );

    //Helper method to check if the HTTP method requires user
    //authentication
    bool httpMethodRequiresUserSession(String method) {
      return ['PUT', 'POST', 'DELETE'].contains(method.toUpperCase());
    }

    //Helper method to check if the query parameters of the url requires
    //user authentication
    bool queryParamRequiresUserSession(Map<String, dynamic> queryParams) {
      return [
        {'private': 1},
        {'hidden': 1},
      ].contains(queryParams);
    }

    //Signing a user up or in doesn't require User-Token field in the
    // request body. But, getting a user requires a session token
    bool pathForSessionAndPasswordRetrievalOps(String url) {
      return [
        '$_baseUrl/session',
        '$_baseUrl/users',
        '$_baseUrl/users/forgot_password',
        '$_baseUrl/users/reset_password',
      ].contains(url);
    }

    /*
    ---For calls that require a user session, pass the user token in via
    the header 'User-Token': 'USER_SESSION_TOKEN'
    ---The interceptor is always added, but the user session token is 
    only added to the headers when necessary, depending on the request 
    method, query parameters used, or url accessed. 
    ---This allows handling both user-authenticated and public 
    requests efficiently.
    */

    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if ((httpMethodRequiresUserSession(options.method) &&
                  !pathForSessionAndPasswordRetrievalOps(options.path)) ||
              // logging out a user requires a user session
              (options.method.toUpperCase() == 'DELETE' &&
                  (options.path.toLowerCase() == '$_baseUrl/session/')) ||
              //handle getting or updating a user, which a requires
              //a user session
              (((options.method.toUpperCase() == 'GET' ||
                      options.method.toUpperCase() == 'PUT')) &&
                  (options.path.toLowerCase() == '$_baseUrl/users/:login')) ||
              (options.method.toUpperCase() == 'GET' &&
                  queryParamRequiresUserSession(options.queryParameters))) {
            String? userSessionToken = await userSessionTokenSupplier?.call();
            if (userSessionToken != null) {
              options.headers.addAll({
                'User-Token': userSessionToken,
              });
            }
          }
          return handler.next(options); // Continue with the request
        },
      ),
    );
  }
}
