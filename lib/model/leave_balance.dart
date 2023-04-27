// To parse this JSON data, do
//
//     final leaveBalanceModel = leaveBalanceModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LeaveBalanceModel leaveBalanceModelFromJson(String str) =>
    LeaveBalanceModel.fromJson(json.decode(str));

String leaveBalanceModelToJson(LeaveBalanceModel data) =>
    json.encode(data.toJson());

class LeaveBalanceModel {
  final List<Employeeleaveblc> employees;

  LeaveBalanceModel({
    required this.employees,
  });

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) =>
      LeaveBalanceModel(
        employees: List<Employeeleaveblc>.from(
            json["employees"].map((x) => Employeeleaveblc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "employees": List<dynamic>.from(employees.map((x) => x.toJson())),
      };
}

class Employeeleaveblc {
  final int eId;
  final String employeeName;
  final int eEmpCode;
  final String branch;
  final String department;
  final String designation;
  final int leaveTypeId;
  final String leaveType;
  final String availableBalance;

  Employeeleaveblc({
    required this.eId,
    required this.employeeName,
    required this.eEmpCode,
    required this.branch,
    required this.department,
    required this.designation,
    required this.leaveTypeId,
    required this.leaveType,
    required this.availableBalance,
  });

  factory Employeeleaveblc.fromJson(Map<String, dynamic> json) =>
      Employeeleaveblc(
        eId: json["e_id"],
        employeeName: json["employee_name"],
        eEmpCode: json["e_emp_code"],
        branch: json["branch"],
        department: json["department"],
        designation: json["designation"],
        leaveTypeId: json["leave_type_id"],
        leaveType: json["leave_type"],
        availableBalance: json["available_balance"],
      );

  Map<String, dynamic> toJson() => {
        "e_id": eId,
        "employee_name": employeeName,
        "e_emp_code": eEmpCode,
        "branch": branch,
        "department": department,
        "designation": designation,
        "leave_type_id": leaveTypeId,
        "leave_type": leaveType,
        "available_balance": availableBalance,
      };
}
