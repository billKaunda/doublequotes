import '../extensions.dart';

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

    final usernameQueryStringPart = username != null
        ? '?type=user&filter=${username.toUrlParameter()}'
        : '';

    final authorQueryStringPart =
        author != null ? '?type=author&filter=${author.toUrlParameter()}' : '';

    final tagQueryStringPart =
        tag != null ? '?type=tag&filter=${tag.toUrlParameter()}' : '';

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
  String buildFollowUrl({
    String? author,
    String? tag,
    String? username,
  }) =>
      coreActivityUrl(
        'follow',
        author: author,
        tag: tag,
        username: username,
      );

  String buildUnfollowUrl({
    String? author,
    String? tag,
    String? username,
  }) =>
      coreActivityUrl(
        'unfollow',
        author: author,
        tag: tag,
        username: username,
      );

  String buildGetFollowersUrl({
    int? page,
    String? author,
    String? username,
    String? tag,
  }) =>
      coreActivityUrl(
        'followers',
        page: page,
        author: author,
        username: username,
        tag: tag,
      );

  String buildGetFollowingUrl({
    int? page,
    String? username,
  }) =>
      coreActivityUrl('following', page: page, username: username);

  String buildDeleteActivityUrl(int activityId) {
    return '$_baseUrl/:$activityId';
  }
}
