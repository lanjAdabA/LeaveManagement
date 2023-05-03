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
  List<Employee>? emplistfinal = [];
  void getemployeelist({
    required int pagenumber,
    required bool ismoredata,
    String? name,
    int? deptid,
    int? desigid,
    int? branchid,
    int? rolename,
    String? isactive,
  }) async {
    emit(PostLoadingState('Fetching Data..'));
    List allemptidlist = [];
    List<String> allempnamelist = [];
    try {
      if (ismoredata) {
        List<Employee>? emplist = await postRepository.getemployeeList(
            pagenumber: pagenumber,
            name: name,
            deptid: deptid,
            branchid: branchid,
            desigid: desigid,
            roleid: rolename,
            isactive: isactive);

        for (var element in emplist!) {
          emplistfinal!.add(element);
          allemptidlist.add(element.employeeId);
          allempnamelist.add(element.employeeName);
          // if (allbranchIdlist.contains(element.id)) {
          //   log('Already Added');
          // } else {
          //   allbranchIdlist.add(element.id);
          // }
          // if (allbranchNamelist.contains(element.name)) {
          //   log('name already addded');
          // } else {
          //   allbranchNamelist.add(element.name);
          // }
        }
        var result = Map.fromIterables(allempnamelist, allemptidlist);
        log('From Cubit for Department :$result');

        if (emplist.length < 15) {
          ismoredata = false;

          log(emplist.length.toString());
          log(emplist.toString());
          if (emplist.isEmpty) {
            emit(PostLoadedState(
                allemployeelist: emplistfinal!,
                isloading: false,
                isempty: true,
                allempnamelist: allempnamelist,
                emptidwithname: result));
          } else {
            emit(PostLoadedState(
                allemployeelist: emplistfinal!,
                isloading: false,
                isempty: false,
                allempnamelist: allempnamelist,
                emptidwithname: result));
          }
        } else {
          log(emplist.length.toString());
          emit(PostLoadedState(
              allemployeelist: emplistfinal!,
              isloading: ismoredata,
              isempty: false,
              allempnamelist: allempnamelist,
              emptidwithname: result));
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
