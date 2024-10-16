class UsersUrlBuilder {
  const UsersUrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://favqs.com/api/users';

  final String _baseUrl;

  String buildSignUpUrl() => _baseUrl;

  String coreUsersUrl(String? action1, {String? action2}) {
    if (action2 != null) {
      return '$_baseUrl/:$action1/$action2';
    } else {
      return '$_baseUrl/:$action1';
    }
  }

  String buildGetUserUrl() => coreUsersUrl('login');

  String buildUpdateUserUrl() => coreUsersUrl('login');

  String buildForgotPasswordUrl() => coreUsersUrl('forgot_password');

  String buildResetPasswordUrl() => coreUsersUrl('reset_password');

  String buildBecomeProUserUrl() => coreUsersUrl('login', action2: 'pro');
}
