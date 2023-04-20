import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leavemanagementadmin/Interceptor/baseapi.dart';
import 'package:leavemanagementadmin/model/dept_listmodel.dart';

part 'get_alldept_state.dart';

class GetAlldeptCubit extends Cubit<GetAlldeptState> {
  GetAlldeptCubit()
      : super(const GetAlldeptState(
            alldeptlist: [],
            deptidwithname: {},
            deptStatus: DeptStatus.initial,
            alldeptnamelist: []));

  API api = API();
  void getalldept() async {
    List alldeptidlist = [];
    List<String> alldeptnamelist = [];

    try {
      final response = await api.sendRequest.get("/api/department");
      if (response.statusCode == 200) {
        List<dynamic> postMaps = response.data;
        var alldept =
            postMaps.map((e) => AllDeptListModel.fromJson(e)).toList();

        for (var element in alldept) {
          alldeptidlist.add(element.id);
          alldeptnamelist.add(element.name);
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

        var result = Map.fromIterables(alldeptidlist, alldeptnamelist);
        log('From Cubit for Department :$result');
        emit(GetAlldeptState(
            alldeptlist: alldept,
            deptidwithname: result,
            deptStatus: DeptStatus.loaded,
            alldeptnamelist: alldeptnamelist));
      } else {
        EasyLoading.showError('Cannot fetch Data');
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }
}
