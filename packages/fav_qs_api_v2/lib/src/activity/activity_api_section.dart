import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:fav_qs_api_v2/src/dio_extensions.dart';
import 'package:fav_qs_api_v2/src/fav_qs_api_v2_exceptions.dart';

import './activity_url_builder.dart';
import './models/activity_models.dart';

class ActivityApiSection {
  static const _errorCodeJsonKey = 'error_code';

  ActivityApiSection({
    this.userSessionTokenSupplier,
    @visibleForTesting Dio? dio,
    @visibleForTesting ActivityUrlBuilder? activityUrlBuilder,
  })  : _dio = dio ?? Dio(),
        _activityUrlBuilder = activityUrlBuilder ?? const ActivityUrlBuilder() {
    _dio.setUpAuthHeaders(userSessionTokenSupplier);
    _dio.interceptors.add(LogInterceptor(responseBody: false));
  }

  final UserSessionTokenSupplier? userSessionTokenSupplier;
  final Dio _dio;
  final ActivityUrlBuilder _activityUrlBuilder;

  Future<ActivitiesListPageRM> getActivitiesListPage({
    int? page,
    String? author,
    String? username,
    String? tag,
  }) async {
    final url = _activityUrlBuilder.buildGetActivityUrl(
      page: page,
      author: author,
      username: username,
      tag: tag,
    );
    return _buildListPage(url, ActivitiesListPageRM) as ActivitiesListPageRM;
  }

  Future<FollowersListPageRM> getFollowersListPage({
    String? author,
    String? username,
    String? tag,
  }) async {
    final url = _activityUrlBuilder.buildGetFollowersUrl(
      author: author,
      username: username,
      tag: tag,
    );

    return _buildListPage(url, FollowingListPageRM) as FollowersListPageRM;
  }

  Future<FollowingListPageRM> getFollowingListPage({
    String? username,
  }) async {
    final url = _activityUrlBuilder.buildGetFollowingUrl(username: username);

    return _buildListPage(url, FollowingListPageRM) as FollowingListPageRM;
  }

  //TODO User a future in the return type or not?
  void followUserTagOrAuthor() {
    final url = _activityUrlBuilder.buildFollowUrl();
    _perfomActivityAction(url);
  }

  void unfollowUserTagOrAuthor() {
    final url = _activityUrlBuilder.buildUnfollowUrl();
    _perfomActivityAction(url);
  }

  Future<void> deleteActivity(int activityId) async {
    final url = _activityUrlBuilder.buildDeleteActivityUrl(activityId);
    final response = await _dio.delete(url);
    final statusCode = response.statusCode;
    final statusMessage = response.statusMessage;

    if (statusCode != 200 && statusMessage!.toUpperCase() != 'OK') {
      throw UserSessionNotFoundFavQsException();
    }
  }

  Future<void> _perfomActivityAction(String url) async {
    final response = await _dio.put(url);
    final statusCode = response.statusCode;
    final statusMessage = response.statusMessage;

    if (statusCode != 200 && statusMessage!.toUpperCase() != 'OK') {
      throw UserSessionNotFoundFavQsException();
    }
  }

  Future<dynamic> _buildListPage(
    String url,
    dynamic listPageClassRM,
  ) async {
    final response = await _dio.get(url);
    final jsonObject = response.data;

    try {
      final listPage = listPageClassRM.fromJson(jsonObject);
      return listPage;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      switch (errorCode) {
        case 30:
          throw UserNotFoundFavQsException();
        case 50:
          throw AuthorNotFoundFavQsException();
        case 60:
          throw TagNotFoundFavQsException();
        case 70:
          throw ActivityNotFoundFavQsException();
        default:
          break;
      }
      rethrow;
    }
  }
}
