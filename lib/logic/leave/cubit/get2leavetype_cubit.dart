import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../Interceptor/baseapi.dart';
import '../../../model/leavetype2model.dart';

part 'get2leavetype_state.dart';

class Get2leavetypeCubit extends Cubit<Get2leavetypeState> {
  Get2leavetypeCubit() : super(Get2leavetypeState());

  API api = API();
  void get2leavetype({required int id}) async {
    LeaveType2Model? specificleavetype;

    try {
      final response = await api.sendRequest.get("/api/leavetype/$id");
      if (response.statusCode == 200) {
        List<dynamic> postMaps = response.data;

        log(postMaps.toString());
        var allleavetype =
            postMaps.map((e) => LeaveType2Model.fromJson(e)).toList();

        for (var element in allleavetype) {
          if (element.canApply == '1') {
            specificleavetype = element;
          }
        }

        // var result = Map.fromIterables(allleavenamelist, allleaveidlist);

        emit(Get2leavetypeState(
          alleavetype: specificleavetype!,
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
