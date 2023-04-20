import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leavemanagementadmin/listener/auth_login_listener.dart';
import 'package:leavemanagementadmin/logic/branch/create_branch_state.dart';

import 'package:leavemanagementadmin/repo/auth_repository.dart';

class BranchCubit extends Cubit<BranchStatus> implements AuthLoginListioner {
  final _authRepository = AuthRepository();
  BranchCubit(BranchStatus initialState) : super(initialState);

  void addbranch({
    required String branchname,
    //required String isactive,
  }) {
    _authRepository.addbranch(
      authLoginListener: this,
      branchname: branchname,
      // isactive: isactive,
    );
    //log("IS_Active : $isactive");
  }

  @override
  void error() {
    emit(
      BranchStatus.error,
    );
  }

  @override
  void loaded() {
    emit(
      BranchStatus.loaded,
    );
  }

  @override
  void loading() {
    emit(BranchStatus.loading);
  }
}
