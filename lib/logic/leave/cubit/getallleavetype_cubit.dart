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
            allleavetypenamelist: [],
            alleavetypeidwithnamecopy: {},
            allleavetypenamelistcopy: [])) {
    getallleavetype();
  }

  API api = API();
  void getallleavetype() async {
    List allleaveidlist = [];
    List<String> allleavenamelist = [];
    List allleaveidlistcopy = [];
    List<String> allleavenamelistcopy = [];

    try {
      final response = await api.sendRequest.get("/api/leavetype");
      if (response.statusCode == 200) {
        List<dynamic> postMaps = response.data['data']['leaves'];

        log(postMaps.toString());
        var allleavetype = postMaps.map((e) => Leaf.fromJson(e)).toList();
        var allleavetypecopy = allleavetype;
        allleavetypecopy.removeRange(0, 2);
        for (var element in allleavetype) {
          allleaveidlist.add(element.id);
          allleavenamelist.add(element.name);
        }
        for (var element in allleavetypecopy) {
          allleaveidlistcopy.add(element.id);
          allleavenamelistcopy.add(element.name);
        }

        var result = Map.fromIterables(allleaveidlist, allleavenamelist);
        log('From Cubit For Leavetype :$result');

        var result2 =
            Map.fromIterables(allleavenamelistcopy, allleaveidlistcopy);
        log('From Cubit For Leavetype :$result2');

        emit(GetallleavetypeState(
            alleavetype: allleavetype,
            alleavetypeidwithname: result,
            allleavetypenamelist: allleavenamelist,
            alleavetypeidwithnamecopy: result2,
            allleavetypenamelistcopy: allleavenamelistcopy));
      } else {
        EasyLoading.showError('Cannot fetch Data');
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }
}
