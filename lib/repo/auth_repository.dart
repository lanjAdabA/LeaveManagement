import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:leavemanagementadmin/Interceptor/diointerceptor.dart';
import 'package:leavemanagementadmin/Interceptor/storetoken.dart';
import 'package:leavemanagementadmin/constant/apiendpoint.dart';
import 'package:leavemanagementadmin/listener/auth_login_listener.dart';

import 'package:leavemanagementadmin/model/emp%20_listmodel.dart';

class AuthRepository {
  static const baseUrl = "https://staging.leave.globizs.com";
  static const loginUrl = "/api/auth/login";
  static const verifyUser = "/api/auth/login/verify";

//Sending Otp to Email
  late final Dio dio;
//
//
  AuthRepository() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    dio.interceptors.add(DioInterceptor());
  }

// Verify Otp From Email
  Future Verifyemail(
      {required String otp,
      required AuthLoginListioner authLoginListener,
      required String emailorphone,
      required String userorphone}) async {
    authLoginListener.loading();

    try {
      final response = await dio.post(
        verifyUser,
        data: {userorphone: emailorphone, "otp": otp},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Verify mail response' + response.data['message']);
        Store.setToken(response.data['data']['accessToken']);

        authLoginListener.loaded();
      } else {
        print('error');
        authLoginListener.error();
        // Login failed
        throw Exception('Failed to log in');
      }
    } catch (e) {
      authLoginListener.error();
      rethrow;
    }
  }

  Future phonelogin(
      {required String phone,
      required AuthLoginListioner authLoginListener}) async {
    authLoginListener.loading();
    try {
      final response = await dio.post(
        loginUrl,
        data: {"phone": phone},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Login successful
        String token = response.data['token'];
        authLoginListener.loaded();
        return token;
      } else {
        authLoginListener.error();
        // Login failed
        throw Exception('Failed to log in');
      }
    } catch (e) {
      authLoginListener.error();
      rethrow;
    }
  }

  // Add Branch
  Future<dynamic> addbranch({
    required String branchname,
    // required String isactive,
    required AuthLoginListioner authLoginListener,
  }) async {
    authLoginListener.loading();
    try {
      var response = await dio.post(
        branchaddurl,
        data: {
          "name": branchname,
          //"is_activ": isactive
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Successfully added branch name");
        authLoginListener.loaded();
        EasyLoading.showToast("Successfully added");
      } else {
        authLoginListener.error();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Update Branch

  Future<dynamic> updatebranch({
    required int id,
    required String branchname,
    required String isactive,

    // required String isactive,
    required AuthLoginListioner authLoginListener,
  }) async {
    authLoginListener.loading();
    try {
      var response = await dio.patch(
        "https://staging.leave.globizs.com/api/admin/update/branch/$id",
        data: {
          "name": branchname,
          "is_active": isactive
          //"is_activ": isactive
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Successfully Update branch data");
        authLoginListener.loaded();
      } else {}
    } catch (e) {
      authLoginListener.error();
      log(e.toString());
    }
  }

// Post DEPARTMENT
  Future<dynamic> postdept({
    required String departmentname,
    // required String isactive,
    required AuthLoginListioner authLoginListener,
  }) async {
    authLoginListener.loading();
    try {
      var response = await dio.post(
        postdeptUrl,
        data: {
          "name": departmentname,
          //"is_activ": isactive
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Successfully added department name");
        authLoginListener.loaded();
      } else {
        authLoginListener.error();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Update Department

  Future<dynamic> updatedept({
    required int id,
    required String branchname,
    required String isactive,
    required AuthLoginListioner authLoginListener,
  }) async {
    authLoginListener.loading();
    try {
      var response = await dio.patch(
        "https://staging.leave.globizs.com/api/department/$id",
        data: {
          "name": branchname,
          "is_active": isactive
          //"is_activ": isactive
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Successfully Update Department data");
        authLoginListener.loaded();
      } else {}
    } catch (e) {
      authLoginListener.error();
      log(e.toString());
    }
  }

  // Delete DEPARTMENT
  Future<dynamic> deletedept({
    required int id,
    required AuthLoginListioner authLoginListener,
  }) async {
    authLoginListener.loading();
    try {
      var response = await dio.delete(
        "https://staging.leave.globizs.com/api/department/$id",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Successfully Delete Deparment data");
        authLoginListener.loaded();
      } else {}
    } catch (e) {
      authLoginListener.error();
      log(e.toString());
    }
  }

  /// ADD DESIGNATION

  Future<dynamic> postdesignation({
    required String designationname,
    // required String isactive,
    required AuthLoginListioner authLoginListener,
  }) async {
    authLoginListener.loading();
    try {
      var response = await dio.post(
        postdesignationURL,
        data: {
          "name": designationname,
          //"is_activ": isactive
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Successfully added designation name");
        authLoginListener.loaded();
      } else {
        authLoginListener.error();
      }
    } catch (e) {
      authLoginListener.error();
      log(e.toString());
    }
  }

  // GET Employee List

  // UPDATE DESIGNATION
  Future<dynamic> updatedesign({
    required int id,
    required String designname,
    required String isactive,
    required AuthLoginListioner authLoginListener,
  }) async {
    authLoginListener.loading();
    try {
      var response = await dio.patch(
        "https://staging.leave.globizs.com/api/designation/$id",
        data: {
          "name": designname,
          "is_active": isactive
          //"is_activ": isactive
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Successfully Update Designation data");
        authLoginListener.loaded();
      } else {}
    } catch (e) {
      authLoginListener.error();
      log(e.toString());
    }
  }

  // Delete DESIGNATION
  Future<dynamic> deletedesign({
    required int id,
    required AuthLoginListioner authLoginListener,
  }) async {
    authLoginListener.loading();
    try {
      var response = await dio.delete(
        "https://staging.leave.globizs.com/api/designation/$id",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Successfully Update Designation data");
        authLoginListener.loaded();
      } else {}
    } catch (e) {
      authLoginListener.error();
      log(e.toString());
    }
  }

  // GET BRANCH

  // GET Employee List

  Future<List<Employee>?> getemployeeList(
      {required int datalimit,
      String? name,
      int? deptid,
      int? desigid,
      int? branchid,
      int? roleid}) async {
    try {
      final response = await dio.get("/api/admin/employees", queryParameters: {
        "limit": datalimit,
        "page_no": 1,
        "name": name ?? "",
        "department_id": deptid ?? 0,
        "designation_id": desigid ?? 0,
        "branch_id": branchid ?? 0,
        "role_id": roleid ?? 0
      });
      if (response.statusCode == 200) {
        log(response.data.toString());
        List<dynamic> postMaps = response.data['employees'];

        return postMaps.map((e) => Employee.fromJson(e)).toList();
      } else {
        EasyLoading.showError('Cannot fetch Data');
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  // Create Employee
  void createEmployee({
    required String empname,
    required String empusername,
    required String email,
    required int empcode,
    required String phonenumber,
    required int deptid,
    required int designid,
    required int branchid,
    required int roleid,
    required String dateofjoining,
    required String emptype,

    // required String isactive,
    required AuthLoginListioner authLoginListener,
  }) async {
    authLoginListener.loading();
    try {
      var response = await dio.post(createempUrl, data: {
        "username": empusername,
        "email": email,
        "emp_code": empcode,
        "name": empname,
        "branch_id": branchid,
        "department_id": deptid,
        "designation_id": designid,
        "date_of_joining": dateofjoining,
        "phone": phonenumber,
        "emp_type": emptype,
        "role": roleid
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Successfully added branch name");
        authLoginListener.loaded();
        EasyLoading.showToast("Successfully added Employee");
      } else {
        authLoginListener.error();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void updateEmployee({
    required int id,
    required String email,
    required String empname,
    required int empcode,
    required String phonenumber,
    required int deptid,
    required int designid,
    required int branchid,
    required int roleid,
    required String dateofjoining,
    required String emptype,

    // required String isactive,
    required AuthLoginListioner authLoginListener,
  }) async {
    authLoginListener.loading();
    try {
      var response = await dio.patch('/api/admin/update/employee/$id', data: {
        "emp_code": empcode,
        "email": email,
        "name": empname,
        "branch_id": branchid,
        "department_id": deptid,
        "designation_id": designid,
        "date_of_joining": dateofjoining,
        "phone": phonenumber,
        "emp_type": emptype,
        "role": roleid
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Successfully updated employee details");
        authLoginListener.loaded();
        EasyLoading.showToast("Successfully Updated Employee");
      } else {
        authLoginListener.error();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool?> checkempcode(String empcode) async {
    try {
      bool resultbool;
      final response = await dio.get("/api/admin/employee/check/$empcode");
      if (response.statusCode == 200) {
        if (response.data == 'false') {
          resultbool = false;
        } else {
          resultbool = true;
        }

        return resultbool;
      } else {
        EasyLoading.showError('Cannot fetch Data');
      }
    } catch (ex) {
      rethrow;
    }
    return null;
  }

  void createleave({
    required int empid,
    required int leavetypeid,
    required String startdate,
    required String enddate,
    required String reasonforleave,
    required int halfday,
    required int daysection,

    // required String isactive,
    required AuthLoginListioner authLoginListener,
  }) async {
    authLoginListener.loading();
    try {
      final data = {
        "leave_type_id": leavetypeid,
        "reason_for_leave": reasonforleave,
        "half_day": halfday,
        "day_section": daysection,
        "leave_apply_for": empid,
        "from_date": startdate,
        "to_date": enddate,
      };
      var response =
          await dio.post(createleaveurl, data: FormData.fromMap(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Successfully added Leave");
        authLoginListener.loaded();
        EasyLoading.showToast("Successfully added Leave");
      } else {
        authLoginListener.error();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
