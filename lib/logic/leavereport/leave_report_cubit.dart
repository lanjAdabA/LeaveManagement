import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leavemanagementadmin/Interceptor/baseapi.dart';
import 'package:leavemanagementadmin/model/leave_report.dart';

part 'leave_report_state.dart';

class GetLeaveReportCubit extends Cubit<GetLeaveReportState> {
  GetLeaveReportCubit() : super(const GetLeaveReportState(leavereportlist: []));

  API api = API();

  void getleavereport({
    String? startdate,
    String? enddate,
  }) async {
    try {
      log("Leave cubit ");
      final response = await api.sendRequest.get(
          "/api/admin/employee/getleaves",
          queryParameters: {"from": startdate, "to": enddate});
      log("Start date : $startdate");
      log("end date : $enddate");

      if (response.statusCode == 200) {
        List<dynamic> postMaps = response.data;
        var alldesign =
            postMaps.map((e) => LeaveReportModel.fromJson(e)).toList();

        emit(GetLeaveReportState(leavereportlist: alldesign));
        log("LEave report :$alldesign ");
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
