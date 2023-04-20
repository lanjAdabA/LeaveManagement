import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leavemanagementadmin/Interceptor/baseapi.dart';
import 'package:leavemanagementadmin/model/branch_list.dart';

part 'getallbranch_state.dart';

class GetallbranchCubit extends Cubit<GetallbranchState> {
  GetallbranchCubit()
      : super(const GetallbranchState(
          allbranchlist: [],
          branchidwithname: {},
          allbranchnamelist: [],
        ));

  List allbranchIdlist = [];
  List<String> allbranchNamelist = [];
  API api = API();
  void getallbranch() async {
    try {
      final response = await api.sendRequest.get("/api/admin/get/branch");
      if (response.statusCode == 200) {
        List<dynamic> postMaps = response.data;
        var allbranch = postMaps.map((e) => AllBranchList.fromJson(e)).toList();

        for (var element in allbranch) {
          allbranchIdlist.add(element.id);
          allbranchNamelist.add(element.name);
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

        var result = Map.fromIterables(allbranchIdlist, allbranchNamelist);
        log('From Cubit For Branch :$result');
        emit(GetallbranchState(
          branchidwithname: result,
          allbranchlist: allbranch,
          allbranchnamelist: allbranchNamelist,
        ));
      } else {
        EasyLoading.showError('Cannot fetch Data');
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }
}
