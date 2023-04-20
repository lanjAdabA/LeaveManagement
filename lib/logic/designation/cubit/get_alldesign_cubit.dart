import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../Interceptor/baseapi.dart';
import '../../../model/design_listmodel.dart';

part 'get_alldesign_state.dart';

class GetAlldesignCubit extends Cubit<GetAlldesignState> {
  GetAlldesignCubit()
      : super(const GetAlldesignState(
            alldesignlist: [],
            designidwithname: {},
            alldesignationnamelist: []));

  API api = API();
  void getalldesign() async {
    List alldesignidlist = [];
    List<String> alldesignamelist = [];

    try {
      final response = await api.sendRequest.get("/api/designation");
      if (response.statusCode == 200) {
        List<dynamic> postMaps = response.data;
        var alldesign =
            postMaps.map((e) => AllDesignModel.fromJson(e)).toList();

        for (var element in alldesign) {
          alldesignidlist.add(element.id);
          alldesignamelist.add(element.name);
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

        var result = Map.fromIterables(alldesignidlist, alldesignamelist);
        log('From Cubit For Designatio :$result');
        emit(GetAlldesignState(
            alldesignlist: alldesign,
            designidwithname: result,
            alldesignationnamelist: alldesignamelist));
      } else {
        EasyLoading.showError('Cannot fetch Data');
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }
}
