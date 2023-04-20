import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:leavemanagementadmin/listener/auth_login_listener.dart';
import 'package:leavemanagementadmin/logic/branch/update_branch_state.dart';

import 'package:leavemanagementadmin/repo/auth_repository.dart';

class UpdateBranchCubit extends Cubit<UpdateBranchStatus>
    implements AuthLoginListioner {
  final _authRepository = AuthRepository();
  UpdateBranchCubit(UpdateBranchStatus initialState) : super(initialState);

  void updatebranch({
    required String branchname,
    required int id,
    required String isactive,
  }) {
    _authRepository.updatebranch(
        authLoginListener: this,
        branchname: branchname,
        isactive: isactive,
        id: id

        // isactive: isactive,
        );
    //log("IS_Active : $isactive");
  }

  @override
  void error() {
    emit(
      UpdateBranchStatus.error,
    );
  }

  @override
  void loaded() {
    emit(
      UpdateBranchStatus.loaded,
    );
  }

  @override
  void loading() {
    emit(UpdateBranchStatus.loading);
  }
}
