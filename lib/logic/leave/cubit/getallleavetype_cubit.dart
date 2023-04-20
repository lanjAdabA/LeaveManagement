import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../Interceptor/baseapi.dart';
import '../../../model/leavetypemodel.dart';

part 'getallleavetype_state.dart';

class GetallleavetypeCubit extends Cubit<GetallleavetypeState> {
  GetallleavetypeCubit()
      : super(const GetallleavetypeState(
            alleavetype: [],
            alleavetypeidwithname: {},
            allleavetypenamelist: [])) {
    getallleavetype();
  }

  API api = API();
  void getallleavetype() async {
    List allleaveidlist = [];
    List<String> allleavenamelist = [];

    try {
      final response = await api.sendRequest.get("/api/leavetype");
      if (response.statusCode == 200) {
        List<dynamic> postMaps = response.data['data']['leaves'];

        log(postMaps.toString());
        var alldesign = postMaps.map((e) => Leaf.fromJson(e)).toList();

        for (var element in alldesign) {
          allleaveidlist.add(element.id);
          allleavenamelist.add(element.name);
        }

        var result = Map.fromIterables(allleaveidlist, allleavenamelist);
        log('From Cubit For Leavetype :$result');
        emit(GetallleavetypeState(
            alleavetype: alldesign,
            alleavetypeidwithname: result,
            allleavetypenamelist: allleavenamelist));
      } else {
        EasyLoading.showError('Cannot fetch Data');
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }
}
