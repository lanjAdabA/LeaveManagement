import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../listener/auth_login_listener.dart';
import '../../../../repo/auth_repository.dart';

part 'createleave_state.dart';

class CreateleaveCubit extends Cubit<CreateLeaveStatus>
    implements AuthLoginListioner {
  final _authRepository = AuthRepository();
  CreateleaveCubit(CreateLeaveStatus initialState) : super(initialState);

  void createleave({
    required int empid,
    required int leavetypeid,
    required String startdate,
    required String enddate,
    required String reasonforleave,
    required int halfday,
    required int daysection,
    //required String isactive,
  }) {
    _authRepository.createleave(
        authLoginListener: this,
        daysection: daysection,
        empid: empid,
        enddate: enddate,
        halfday: halfday,
        leavetypeid: leavetypeid,
        reasonforleave: reasonforleave,
        startdate: startdate);
    //log("IS_Active : $isactive");
  }

  @override
  void error() {
    emit(
      CreateLeaveStatus.error,
    );
  }

  @override
  void loaded() {
    emit(
      CreateLeaveStatus.loaded,
    );
  }

  @override
  void loading() {
    emit(CreateLeaveStatus.loading);
  }
}
