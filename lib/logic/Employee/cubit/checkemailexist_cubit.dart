import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leavemanagementadmin/Interceptor/baseapi.dart';
import 'package:leavemanagementadmin/constant/login_emailcheck.dart';

part 'checkemailexist_state.dart';

class CheckemailexistCubit extends Cubit<CheckemailexistState> {
  CheckemailexistCubit() : super(const CheckemailexistState(isexist: ''));

  API api = API();
  void checkemailexist(String email) async {
    log('Coming cubit');
    try {
      log('Emp Code :$email');
      if (email.isEmpty) {
        emit(const CheckemailexistState(isexist: ''));
      } else {
        if (isEmail(email)) {
          final response = await api.sendRequest
              .post("/api/admin/employee/check/email", data: {"email": email});
          if (response.statusCode == 200 || response.statusCode == 201) {
            log('From Cubit' + response.data);
            emit(CheckemailexistState(isexist: response.data));
          } else {
            EasyLoading.showError('Cannot fetch Data');
          }
        } else {
          emit(const CheckemailexistState(isexist: 'invalid'));
        }
      }
    } catch (ex) {
      rethrow;
    }
  }
}
