// To parse this JSON data, do
//
//     final leaveBalanceModel = leaveBalanceModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<LeaveBalanceModel> leaveBalanceModelFromJson(String str) =>
    List<LeaveBalanceModel>.from(
        json.decode(str).map((x) => LeaveBalanceModel.fromJson(x)));

String leaveBalanceModelToJson(List<LeaveBalanceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveBalanceModel {
  final int id;
  final int empCode;
  final String name;
  final String branch;
  final String department;
  final String designation;
  final int leaveTypeId;
  final String leaveType;
  final String availableBalance;

  LeaveBalanceModel({
    required this.id,
    required this.empCode,
    required this.name,
    required this.branch,
    required this.department,
    required this.designation,
    required this.leaveTypeId,
    required this.leaveType,
    required this.availableBalance,
  });

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) =>
      LeaveBalanceModel(
        id: json["id"],
        empCode: json["emp_code"],
        name: json["name"],
        branch: json["branch"],
        department: json["department"],
        designation: json["designation"],
        leaveTypeId: json["leave_type_id"],
        leaveType: json["leave_type"],
        availableBalance: json["available_balance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emp_code": empCode,
        "name": name,
        "branch": branch,
        "department": department,
        "designation": designation,
        "leave_type_id": leaveTypeId,
        "leave_type": leaveType,
        "available_balance": availableBalance,
      };
}
