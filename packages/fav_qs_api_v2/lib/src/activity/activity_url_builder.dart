class ActivityUrlBuilder {
  const ActivityUrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://favqs.com/api/activities';

  final String _baseUrl;

  String coreActivityUrl(
    String? activity, {
    int? page,
    String? author,
    String? username,
    String? tag,
  }) {
    assert(
        (username != null && author != null) ||
            (username != null && tag != null) ||
            (author != null && tag != null),
        'FavQs doesn\'t support searching by two types (e.g author & user)'
        ' simultaneously.');

    final activityQueryStringPart = activity ?? '';

    final pageQueryStringPart = page != null ? '&page=$page' : '';

    final usernameQueryStringPart =
        username != null ? '?type=user&filter=$username' : '';

    final authorQueryStringPart =
        author != null ? '?type=author&filter=$author' : '';

    final tagQueryStringPart = tag != null ? '?type=tag&filter=$tag' : '';

    return '$_baseUrl/$activityQueryStringPart/$usernameQueryStringPart$authorQueryStringPart$tagQueryStringPart$pageQueryStringPart';
  }

  String buildGetActivityUrl({
    int? page,
    String? author,
    String? username,
    String? tag,
  }) =>
      coreActivityUrl(
        null,
        page: page,
        author: author,
        username: username,
        tag: tag,
      );
  String buildFollowUrl() => coreActivityUrl('follow');

  String buildUnfollowUrl() => coreActivityUrl('unfollow');

  String buildGetFollowersUrl({
    String? author,
    String? username,
    String? tag,
  }) =>
      coreActivityUrl(
        'followers',
        author: author,
        username: username,
        tag: tag,
      );

  String buildGetFollowingUrl({
    String? username,
  }) =>
      coreActivityUrl('following', username: username);

  String buildDeleteActivityUrl(int activityId) {
    return '$_baseUrl/:$activityId';
  }
}
