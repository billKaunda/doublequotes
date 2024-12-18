import 'package:dio/dio.dart';
import 'package:fav_qs_api_v2/src/extensions.dart';
import 'package:fav_qs_api_v2/src/fav_qs_api_v2_exceptions.dart';

import './filters/filters_models.dart';

class TypeaheadApiSection {
  static const _errorCodeJsonKey = 'error_code';

  TypeaheadApiSection({
    this.userSessionTokenSupplier,
    String? baseUrl,
    Dio? dio,
  })  : _dio = dio ?? Dio(),
        _baseUrl = baseUrl ?? 'https://favqs.com/api/typeahead' {
    _dio.setUpAuthHeaders(userSessionTokenSupplier);
    _dio.interceptors.add(LogInterceptor(responseBody: false));
  }
  final UserSessionTokenSupplier? userSessionTokenSupplier;
  final String _baseUrl;
  final Dio _dio;

  Future<TypeaheadRM> getTypeahead() async {
    final response = await _dio.get(_baseUrl);
    final jsonObject = response.data;

    try {
      final typeahead = TypeaheadRM.fromJson(jsonObject);
      return typeahead;
    } catch (error) {
      final int errorCode = jsonObject[_errorCodeJsonKey];
      switch (errorCode) {
        case 10:
          throw InvalidRequestFavQsException();
        case 11:
          throw PermissionDeniedFavQsException();
        default:
          break;
      }
      rethrow;
    }
  }
}
