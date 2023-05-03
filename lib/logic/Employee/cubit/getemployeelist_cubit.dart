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
      {required int pagenumber,
      required bool ismoredata,
      String? name,
      int? deptid,
      int? desigid,
      int? branchid,
      int? rolename,
      String? isactive,
      int? limit}) async {
    emit(PostLoadingState('Fetching Data..'));
    List allemptidlist = [];
    List<String> allempnamelist = [];
    try {
      if (ismoredata) {
        EmployeeListModel? emplist = await postRepository.getemployeeList(
            limit: limit,
            pagenumber: pagenumber,
            name: name,
            deptid: deptid,
            branchid: branchid,
            desigid: desigid,
            roleid: rolename,
            isactive: isactive);

        for (var element in emplist!.employees) {
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

        if (emplist.employees.length < 15) {
          ismoredata = false;

          log(emplist.employees.length.toString());
          log(emplist.employees.toString());
          if (emplist.employees.isEmpty) {
            emit(PostLoadedState(
                allemployeelist: emplist.employees,
                isloading: false,
                isempty: true,
                allempnamelist: allempnamelist,
                emptidwithname: result,
                totalemp: emplist.count));
          } else {
            emit(PostLoadedState(
                allemployeelist: emplist.employees,
                isloading: false,
                isempty: false,
                allempnamelist: allempnamelist,
                emptidwithname: result,
                totalemp: emplist.count));
          }
        } else {
          log(emplist.employees.length.toString());
          emit(PostLoadedState(
              allemployeelist: emplist.employees,
              isloading: ismoredata,
              isempty: false,
              allempnamelist: allempnamelist,
              emptidwithname: result,
              totalemp: emplist.count));
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
