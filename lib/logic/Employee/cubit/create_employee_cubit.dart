import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../listener/auth_login_listener.dart';
import '../../../repo/auth_repository.dart';

part 'create_employee_state.dart';

class CreateEmployeeCubit extends Cubit<CreateEmployeeStatus>
    implements AuthLoginListioner {
  final _authRepository = AuthRepository();
  CreateEmployeeCubit(CreateEmployeeStatus initialState) : super(initialState);

  void createemployee({
    required String empname,
    required String empusername,
    required String email,
    required String gender,
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
    _authRepository.createEmployee(
        empname: empname,
        empusername: empusername,
        email: email,
        empcode: empcode,
        phonenumber: phonenumber,
        deptid: deptid,
        designid: designid,
        branchid: branchid,
        roleid: roleid,
        dateofjoining: dateofjoining,
        emptype: emptype,
        authLoginListener: this,
        gender: gender);
    //log("IS_Active : $isactive");
  }

  @override
  void error() {
    emit(
      CreateEmployeeStatus.error,
    );
  }

  @override
  void loaded() {
    emit(
      CreateEmployeeStatus.loaded,
    );
  }

  @override
  void loading() {
    emit(CreateEmployeeStatus.loading);
  }
}
