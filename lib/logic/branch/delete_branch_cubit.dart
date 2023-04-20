import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leavemanagementadmin/Interceptor/baseapi.dart';
import 'package:leavemanagementadmin/logic/branch/delete_branch_state.dart';

class DeleteBranchCubit extends Cubit<DeleteBranchState> {
  DeleteBranchCubit() : super(DeleteBranchState());

  API api = API();

  void deletebranch(int id) async {
    try {
      final response =
          await api.sendRequest.delete("/api/admin/get/branch/$id");
      if (response.statusCode == 200) {
        log("delete successfully");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
