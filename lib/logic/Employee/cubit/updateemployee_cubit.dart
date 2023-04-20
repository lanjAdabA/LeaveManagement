import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leavemanagementadmin/listener/auth_login_listener.dart';

import '../../../repo/auth_repository.dart';

part 'updateemployee_state.dart';

class UpdateemployeeCubit extends Cubit<UpdateEmployeeStatus>
    implements AuthLoginListioner {
  final _authRepository = AuthRepository();
  UpdateemployeeCubit(UpdateEmployeeStatus initialState) : super(initialState);

  void updateemployee({
    required int id,
    required String email,
    required String empname,
    required int empcode,
    required String phonenumber,
    required int deptid,
    required int designid,
    required int branchid,
    required int roleid,
    required String dateofjoining,
    required String emptype,
    //required String isactive,
  }) {
    _authRepository.updateEmployee(
        empname: empname,
        empcode: empcode,
        phonenumber: phonenumber,
        deptid: deptid,
        designid: designid,
        branchid: branchid,
        roleid: roleid,
        dateofjoining: dateofjoining,
        emptype: emptype,
        authLoginListener: this,
        id: id,
        email: email);
    //log("IS_Active : $isactive");
  }

  @override
  void error() {
    emit(
      UpdateEmployeeStatus.error,
    );
  }

  @override
  void loaded() {
    emit(
      UpdateEmployeeStatus.loaded,
    );
  }

  @override
  void loading() {
    emit(UpdateEmployeeStatus.loading);
  }
}
