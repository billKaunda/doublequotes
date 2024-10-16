class SessionUrlBuilder {
  const SessionUrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://favqs.com/api/session';

  final String _baseUrl;

  String buildSignInUrl() => _baseUrl;

  String buildSignOutUrl() => _baseUrl;
}
