import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../Interceptor/baseapi.dart';
import '../../../model/leavetypemodel2.dart';

part 'getallleavetype_forleavebalance_state.dart';

class GetallleavetypeForleavebalanceCubit
    extends Cubit<GetallleavetypeForleavebalanceState> {
  GetallleavetypeForleavebalanceCubit()
      : super(const GetallleavetypeForleavebalanceState(
            alleavetypeidwithname: {},
            allleavetypenamelist: [],
            alleavetypenamewithcredit: {}));

  API api = API();
  void getallleavetype() async {
    List allleaveidlist = [];
    List<String> allleavenamelist = [];
    List allleavecreditlist = [];

    try {
      final response =
          await api.sendRequest.get("/api/leavetype/all/otherleave");
      if (response.statusCode == 200) {
        List<dynamic> postMaps = response.data;

        log(postMaps.toString());
        var allleavetype =
            postMaps.map((e) => GetallLeavetype2Model.fromJson(e)).toList();

        for (var element in allleavetype) {
          allleaveidlist.add(element.id);
          allleavenamelist.add(element.name);
          allleavecreditlist.add(element.credit);
        }

        var idwithname = Map.fromIterables(allleavenamelist, allleaveidlist);
        var namewithcredit =
            Map.fromIterables(allleavenamelist, allleavecreditlist);

        emit(GetallleavetypeForleavebalanceState(
          alleavetypeidwithname: idwithname,
          allleavetypenamelist: allleavenamelist,
          alleavetypenamewithcredit: namewithcredit,
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
