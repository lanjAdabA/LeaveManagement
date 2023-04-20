import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_flow_state.dart';

class AuthFlowCubit extends Cubit<AuthflowState> {
  AuthFlowCubit() : super(const AuthflowState(status: logStatus.initial));

  void getloginstatus() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('tokken')) {
      log('true tokken is here');
      emit(const AuthflowState(status: logStatus.loggedIn));
    } else {
      emit(const AuthflowState(status: logStatus.loggedOut));
    }
  }
}
