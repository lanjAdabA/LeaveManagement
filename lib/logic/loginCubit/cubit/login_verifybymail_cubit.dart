import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leavemanagementadmin/listener/auth_login_listener.dart';
import 'package:leavemanagementadmin/repo/auth_repository.dart';

part 'login_verifybymail_state.dart';

class LoginVerifybymailCubit extends Cubit<VerifyStatusformail>
    implements AuthLoginListioner {
  final _authRepository = AuthRepository();
  LoginVerifybymailCubit(VerifyStatusformail initialState)
      : super(initialState);

  void verifymail(
      {required String userorphone,
      required String email,
      required String otp}) {
    _authRepository.Verifyemail(
        authLoginListener: this,
        emailorphone: email,
        otp: otp,
        userorphone: userorphone);
  }

  @override
  void error() {
    emit(VerifyStatusformail.error);
  }

  @override
  void loaded() {
    emit(VerifyStatusformail.loaded);
  }

  @override
  void loading() {
    emit(VerifyStatusformail.loading);
  }
}
