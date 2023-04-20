import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leavemanagementadmin/listener/auth_login_listener.dart';
import 'package:leavemanagementadmin/repo/auth_repository.dart';

part 'postdepartment_state.dart';

class PostdepartmentCubit extends Cubit<PostDeptStatus>
    implements AuthLoginListioner {
  final _authRepository = AuthRepository();
  PostdepartmentCubit(PostDeptStatus initialState) : super(initialState);

  void postdept({
    required String deptname,
    //required String isactive,
  }) {
    _authRepository.postdept(
      authLoginListener: this, departmentname: deptname,

      // isactive: isactive,
    );
    //log("IS_Active : $isactive");
  }

  @override
  void error() {
    emit(
      PostDeptStatus.error,
    );
  }

  @override
  void loaded() {
    emit(
      PostDeptStatus.loaded,
    );
  }

  @override
  void loading() {
    emit(PostDeptStatus.loading);
  }
}
