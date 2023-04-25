import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leavemanagementadmin/repo/auth_repository.dart';

import '../../../listener/auth_login_listener.dart';

part 'add_leave_balance_state.dart';

class AddLeaveBalanceCubit extends Cubit<AddLeaveBalanceStatus>
    implements AuthLoginListioner {
  final _authRepository = AuthRepository();

  AddLeaveBalanceCubit(AddLeaveBalanceStatus initialstate)
      : super(initialstate);

  void addleavebalance({
    required int leavetypeid,
    required String empname,

    // required int leaveBAlance,
  }) {
    _authRepository.addleavebalance(
      authLoginListener: this,
      empName: empname,
      leavetypeid: leavetypeid,
    );
    //log("IS_Active : $isactive");
  }

  @override
  void error() {
    emit(
      AddLeaveBalanceStatus.error,
    );
  }

  @override
  void loaded() {
    emit(
      AddLeaveBalanceStatus.loaded,
    );
  }

  @override
  void loading() {
    emit(AddLeaveBalanceStatus.loading);
  }
}
