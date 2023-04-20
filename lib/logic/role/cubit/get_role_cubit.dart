import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../Interceptor/baseapi.dart';
import '../../../model/role_listmodel.dart';

part 'get_role_state.dart';

class GetRoleCubit extends Cubit<GetRoleState> {
  GetRoleCubit()
      : super(const GetRoleState(allrolenamelist: [], rolenamewithid: {})) {
    getallrole();
  }

  API api = API();
  void getallrole() async {
    List allroleidlist = [];
    List<String> allrolenamelist = [];

    try {
      final response = await api.sendRequest.get("/api/auth/role");
      if (response.statusCode == 200) {
        List<dynamic> postMaps = response.data;
        var alldept = postMaps.map((e) => AllRoleModel.fromJson(e)).toList();

        for (var element in alldept) {
          allroleidlist.add(element.id);
          allrolenamelist.add(element.name);
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

        var result = Map.fromIterables(allrolenamelist, allroleidlist);
        log('From Cubit For Role :$result');
        emit(GetRoleState(
            allrolenamelist: allrolenamelist, rolenamewithid: result));
      } else {
        EasyLoading.showError('Cannot fetch Data');
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }
}
