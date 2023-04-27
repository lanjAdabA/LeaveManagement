import 'dart:convert';

List<LeaveBalanceModel> leaveBalanceModelFromJson(String str) =>
    List<LeaveBalanceModel>.from(
        json.decode(str).map((x) => LeaveBalanceModel.fromJson(x)));

String leaveBalanceModelToJson(List<LeaveBalanceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveBalanceModel {
  LeaveBalanceModel({
    required this.id,
    required this.empCode,
    required this.employeeName,
    required this.branch,
    required this.department,
    required this.designation,
    required this.leaveType,
    required this.availableBalance,
    required this.leaveTypeId,
  });

  int id;
  int empCode;
  String employeeName;
  String branch;
  String department;
  String designation;
  String leaveType;
  String availableBalance;
  int leaveTypeId;

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) =>
      LeaveBalanceModel(
        id: json["id"],
        empCode: json["emp_code"],
        employeeName: json["employee_name"],
        branch: json["branch"],
        department: json["department"],
        designation: json["designation"],
        leaveType: json["leave_type"],
        availableBalance: json["available_balance"],
        leaveTypeId: json["leave_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emp_code": empCode,
        "employee_name": employeeName,
        "branch": branch,
        "department": department,
        "designation": designation,
        "leave_type": leaveType,
        "available_balance": availableBalance,
        "leave_type_id": leaveTypeId,
      };
}
