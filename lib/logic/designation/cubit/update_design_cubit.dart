import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:leavemanagementadmin/listener/auth_login_listener.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/update_design_state.dart';

import 'package:leavemanagementadmin/repo/auth_repository.dart';

class UpdateDesignCubit extends Cubit<UpdateDesignStatus>
    implements AuthLoginListioner {
  final _authRepository = AuthRepository();
  UpdateDesignCubit(UpdateDesignStatus initialState) : super(initialState);

  void updatedesign({
    required String designname,
    required int id,
    required String isactive,
  }) {
    _authRepository.updatedesign(
      authLoginListener: this,
      designname: designname,
      isactive: isactive,
      id: id,

      // isactive: isactive,
    );
    //log("IS_Active : $isactive");
  }

  @override
  void error() {
    emit(
      UpdateDesignStatus.error,
    );
  }

  @override
  void loaded() {
    emit(
      UpdateDesignStatus.loaded,
    );
  }

  @override
  void loading() {
    emit(UpdateDesignStatus.loading);
  }
}
