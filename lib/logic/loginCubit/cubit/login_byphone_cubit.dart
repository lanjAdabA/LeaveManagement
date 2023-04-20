import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leavemanagementadmin/listener/auth_login_listener.dart';
import 'package:leavemanagementadmin/repo/auth_repository.dart';

part 'login_byphone_state.dart';

class LoginByphoneCubit extends Cubit<Status2> implements AuthLoginListioner {
  final _authRepository = AuthRepository();
  LoginByphoneCubit(Status2 initialState) : super(initialState);

  void phonelogin({required String phone}) {
    _authRepository.phonelogin(authLoginListener: this, phone: phone);
  }

  @override
  void error() {
    emit(Status2.error);
  }

  @override
  void loaded() {
    emit(Status2.loaded);
  }

  @override
  void loading() {
    emit(Status2.loading);
  }
}
