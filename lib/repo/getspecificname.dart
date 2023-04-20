import 'dart:developer';

import 'package:dio/dio.dart';

import '../constant/apiendpoint.dart';

class Fetchdatabyid {
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

//Sending Otp to Email
  Future<String> getspecificbrance({
    required String id,
  }) async {
    try {
      final response = await dio.get('/branch/$id');

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data['name']);
        // Login successful
        return response.data['name'];
      } else {
        print('error');

        // Login failed
        throw Exception('Failed to log in');
      }
    } catch (e) {
      rethrow;
    }
  }
}
