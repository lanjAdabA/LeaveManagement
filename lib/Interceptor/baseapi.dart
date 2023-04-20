import 'package:dio/dio.dart';
import 'package:leavemanagementadmin/Interceptor/diointerceptor.dart';
import 'package:leavemanagementadmin/constant/apiendpoint.dart';

class API {
  final Dio _dio = Dio();

  API() {
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(DioInterceptor());
  }

  Dio get sendRequest => _dio;
}
