import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:leavemanagementadmin/listener/auth_login_listener.dart';
import 'package:leavemanagementadmin/logic/department/cubit/update_dept.state.dart';

import 'package:leavemanagementadmin/repo/auth_repository.dart';

class UpdateDeptCubit extends Cubit<UpdateDeptStatus>
    implements AuthLoginListioner {
  final _authRepository = AuthRepository();
  UpdateDeptCubit(UpdateDeptStatus initialState) : super(initialState);

  void updatedept({
    required String deptname,
    required int id,
    required String isactive,
  }) {
    _authRepository.updatedept(
        authLoginListener: this,
        branchname: deptname,
        isactive: isactive,
        id: id

        // isactive: isactive,
        );
    //log("IS_Active : $isactive");
  }

  @override
  void error() {
    emit(
      UpdateDeptStatus.error,
    );
  }

  @override
  void loaded() {
    emit(
      UpdateDeptStatus.loaded,
    );
  }

  @override
  void loading() {
    emit(UpdateDeptStatus.loading);
  }
}
