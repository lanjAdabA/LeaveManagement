import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leavemanagementadmin/Interceptor/baseapi.dart';

import '../../../model/leave_balance.dart';

part 'leave_balance_state.dart';

class GetLeaveBalanceCubit extends Cubit<GetLeaveBalanceState> {
  GetLeaveBalanceCubit()
      : super(const GetLeaveBalanceState(leavebalancelist: []));

  API api = API();

  void getleavebalance({
    String? name,
    String? branch,
    String? design,
    String? dept,
    int? leave_type_no,
  }) async {
    List<dynamic> branchnamelist = [];
    List<dynamic> deptnamelist = [];
    List<dynamic> designnamelist = [];
    List<String> leavetypelist = [];
    List<dynamic> leavetypeidlist = [];
    try {
      log("Leave cubit ");
      final response = await api.sendRequest
          .get("/api/admin/employee/balance", queryParameters: {
        "employee_name": name ?? "",
        "branch": branch ?? "",
        "department": dept ?? "",
        "designation": design ?? "",
        "leave_type_no": leave_type_no
      });
      // log("Start date : $startdate");
      // log("end date : $enddate");

      if (response.statusCode == 200) {
        List<dynamic> postMaps = response.data;
        var alldata =
            postMaps.map((e) => LeaveBalanceModel.fromJson(e)).toList();

        for (var element in alldata) {
          branchnamelist.add(element.branch);
          deptnamelist.add(element.department);
          designnamelist.add(element.designation);
          leavetypelist.add(element.leaveType);
          leavetypeidlist.add(element.leaveTypeId);
        }
        var result = Map.fromIterables(leavetypelist, leavetypeidlist);
        log("Leave Balance : $result");

        emit(GetLeaveBalanceState(
            leavebalancelist: alldata,
            branchnamelist: branchnamelist,
            deptnamelist: deptnamelist,
            designnamelist: designnamelist,
            leavetypelist: leavetypelist,
            leaveidandname: result));
        log("LEave Balance :$alldata ");
      } else {
        EasyLoading.showError('Cannot fetch Data');
      }
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
    return null;
  }
}
