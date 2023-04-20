import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leavemanagementadmin/Interceptor/baseapi.dart';

part 'check_empcode_state.dart';

class CheckEmpcodeCubit extends Cubit<CheckEmpcodeState> {
  CheckEmpcodeCubit() : super(const CheckEmpcodeState(isexist: ''));

  API api = API();
  void checkempcode(String empcode) async {
    log('Coming cubit');
    try {
      log('Emp Code :$empcode');
      if (empcode.isEmpty) {
        emit(const CheckEmpcodeState(isexist: ''));
      } else {
        final response =
            await api.sendRequest.get("/api/admin/employee/check/$empcode");
        if (response.statusCode == 200) {
          log('From Cubit' + response.data);
          emit(CheckEmpcodeState(isexist: response.data));
        } else {
          EasyLoading.showError('Cannot fetch Data');
        }
      }
    } catch (ex) {
      rethrow;
    }
  }
}
