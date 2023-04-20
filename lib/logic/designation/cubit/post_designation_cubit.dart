import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:leavemanagementadmin/listener/auth_login_listener.dart';
import 'package:leavemanagementadmin/repo/auth_repository.dart';

part 'post_designation_state.dart';

class PostDesignationCubit extends Cubit<PostDesignStatus>
    implements AuthLoginListioner {
  final _authRepository = AuthRepository();
  PostDesignationCubit(PostDesignStatus initialState) : super(initialState);

  void postdesignation({
    required String designation_name,
    //required String isactive,
  }) {
    _authRepository.postdesignation(
      authLoginListener: this,
      designationname: designation_name,

      // isactive: isactive,
    );
    //log("IS_Active : $isactive");
  }

  @override
  void error() {
    emit(
      PostDesignStatus.error,
    );
  }

  @override
  void loaded() {
    emit(
      PostDesignStatus.loaded,
    );
  }

  @override
  void loading() {
    emit(PostDesignStatus.loading);
  }
}
