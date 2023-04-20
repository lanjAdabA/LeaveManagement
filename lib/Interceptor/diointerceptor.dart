import 'package:dio/dio.dart';

import 'package:leavemanagementadmin/Interceptor/storetoken.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await Store.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    options.headers["Content-Type"] = "application/json";
    super.onRequest(options, handler);
  }
}
