import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:leavemanagementadmin/listener/auth_login_listener.dart';
import 'package:leavemanagementadmin/logic/department/cubit/delete_dept_state.dart';

import 'package:leavemanagementadmin/repo/auth_repository.dart';

class DeleteDeptCubit extends Cubit<DeleteDeptStatus>
    implements AuthLoginListioner {
  final _authRepository = AuthRepository();
  DeleteDeptCubit(DeleteDeptStatus initialState) : super(initialState);

  void deletedept({
    required int id,
  }) {
    _authRepository.deletedept(
      authLoginListener: this,

      id: id,

      // isactive: isactive,
    );
    //log("IS_Active : $isactive");
  }

  @override
  void error() {
    emit(
      DeleteDeptStatus.error,
    );
  }

  @override
  void loaded() {
    emit(
      DeleteDeptStatus.loaded,
    );
  }

  @override
  void loading() {
    emit(DeleteDeptStatus.loading);
  }
}
