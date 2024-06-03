import 'package:dio/dio.dart';
import 'package:graduation/auth/cach/cach_helper.dart';
import 'package:graduation/auth/core_login/api/end_point.dart';

class apiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Content-Type'] = 'application/json';
    options.headers['Postman-Token'] =
        CacheHelper().getData(key: apikey.token) != null
            ? ' ${CacheHelper().getData(key: apikey.token)}'
            : null;
    super.onRequest(options, handler);
  }
}
