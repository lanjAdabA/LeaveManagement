import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leavemanagementadmin/model/emp%20_listmodel.dart';
import 'package:leavemanagementadmin/repo/auth_repository.dart';

part 'getemployeelist_state.dart';

class GetemployeelistCubit extends Cubit<PostState> {
  GetemployeelistCubit() : super(PostinitialState(''));

  AuthRepository postRepository = AuthRepository();

  void getemployeelist(
      {required int datalimit,
      required bool ismoredata,
      String? name,
      int? deptid,
      int? desigid,
      int? branchid,
      int? rolename}) async {
    emit(PostLoadingState('Fetching Data..'));
    try {
      if (ismoredata) {
        List<Employee>? emplist = await postRepository.getemployeeList(
            datalimit: datalimit,
            name: name,
            deptid: deptid,
            branchid: branchid,
            desigid: desigid,
            roleid: rolename);

        if (emplist!.length < datalimit) {
          log('item is lesss than $datalimit');
          ismoredata = false;

          log(emplist.length.toString());
          log(emplist.toString());
          if (emplist.isEmpty) {
            emit(PostLoadedState(
                allemployeelist: emplist, isloading: false, isempty: true));
          } else {
            emit(PostLoadedState(
                allemployeelist: emplist, isloading: false, isempty: false));
          }
        } else {
          log(emplist.length.toString());
          emit(PostLoadedState(
              allemployeelist: emplist, isloading: ismoredata, isempty: false));
        }
      }
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.connectionError) {
        emit(PostErrorState(
            "Can't fetch posts, please check your internet connection!"));
        EasyLoading.showError(
            "Can't fetch posts, please check your internet connection!");
      } else {
        EasyLoading.showError(
            "Can't fetch posts, please check your internet connection!");
      }
    }
  }
}
