import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'login_bymail_state.dart';

class LoginBymailCubit extends Cubit<LoginBymailState> {
  LoginBymailCubit(initialState) : super(const LoginBymailState(issend: false));
  static const baseUrl = "https://staging.leave.globizs.com";
  static const loginUrl = "/api/auth/login";
  static const verifyUser = "/api/auth/login/verify";
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future emaillogin({
    required String email,
  }) async {
    EasyLoading.show(status: 'Please Wait..');

    try {
      final response = await dio.post(
        loginUrl,
        data: {"username": email},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data['message']);
        // Login successful
        EasyLoading.showToast(
          'otp has been sent to your email',
        );
        emit(const LoginBymailState(issend: true));
      } else {
        print('error');
        EasyLoading.showError(
          'Invalid Email',
        );
        // Login failed
        throw Exception('Failed to log in');
      }
    } catch (e) {
      EasyLoading.showError(
        'Invalid Email',
      );
      rethrow;
    }
  }

  Future emaillogin_forreset({
    required String email,
  }) async {
    try {
      final response = await dio.post(
        loginUrl,
        data: {"username": email},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data['message']);
        // Login successful

        emit(const LoginBymailState(issend: true));
      } else {
        print('error');

        // Login failed
        throw Exception('Failed to log in');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future phonelogin({
    required String phonenumber,
  }) async {
    EasyLoading.show(status: 'Please Wait..');

    try {
      final response = await dio.post(
        loginUrl,
        data: {"phone": phonenumber},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data['message']);
        // Login successful
        EasyLoading.showToast(
          'otp has been sent to your number',
        );
        emit(const LoginBymailState(issend: true));
      } else {
        print('error');
        EasyLoading.showError(
          'Invalid Number',
        );
        // Login failed
        throw Exception('Failed to log in');
      }
    } catch (e) {
      EasyLoading.showError(
        'Invalid Number',
      );
      rethrow;
    }
  }

  Future phonelogin_forreset({
    required String phonenumber,
  }) async {
    try {
      final response = await dio.post(
        loginUrl,
        data: {"phone": phonenumber},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data['message']);
        // Login successful

        emit(const LoginBymailState(issend: true));
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
