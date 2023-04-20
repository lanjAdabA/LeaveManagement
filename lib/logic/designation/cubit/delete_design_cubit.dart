import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:leavemanagementadmin/listener/auth_login_listener.dart';
import 'package:leavemanagementadmin/logic/designation/cubit/delete_design_state.dart';

import 'package:leavemanagementadmin/repo/auth_repository.dart';

class DeleteDesignCubit extends Cubit<DeleteDesignStatus>
    implements AuthLoginListioner {
  final _authRepository = AuthRepository();
  DeleteDesignCubit(DeleteDesignStatus initialState) : super(initialState);

  void deletedesign({
    required int id,
  }) {
    _authRepository.deletedesign(
      authLoginListener: this,

      id: id,

      // isactive: isactive,
    );
    //log("IS_Active : $isactive");
  }

  @override
  void error() {
    emit(
      DeleteDesignStatus.error,
    );
  }

  @override
  void loaded() {
    emit(
      DeleteDesignStatus.loaded,
    );
  }

  @override
  void loading() {
    emit(DeleteDesignStatus.loading);
  }
}
