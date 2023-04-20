// To parse this JSON data, do
//
//     final employeeListModel = employeeListModelFromJson(jsonString);

import 'dart:convert';

EmployeeListModel employeeListModelFromJson(String str) =>
    EmployeeListModel.fromJson(json.decode(str));

String employeeListModelToJson(EmployeeListModel data) =>
    json.encode(data.toJson());

class EmployeeListModel {
  EmployeeListModel({
    required this.count,
    required this.employees,
  });

  final int count;
  final List<Employee> employees;

  factory EmployeeListModel.fromJson(Map<String, dynamic> json) =>
      EmployeeListModel(
        count: json["count"],
        employees: List<Employee>.from(
            json["employees"].map((x) => Employee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "employees": List<dynamic>.from(employees.map((x) => x.toJson())),
      };
}

class Employee {
  Employee({
    required this.employeeId,
    required this.employeeName,
    required this.employeeEmpCode,
    required this.employeeDateOfJoining,
    required this.employeePhoto,
    required this.employeePhone,
    required this.employeeEmpStatus,
    required this.employeeCreatedAt,
    required this.employeeUpdatedAt,
    required this.employeeIsActive,
    required this.employeeUserId,
    required this.employeeBranchId,
    required this.employeeDepartmentId,
    required this.employeeDesignationId,
    required this.employeeEmployeeGradeId,
    required this.role,
    required this.email,
  });

  final int employeeId;
  final String employeeName;
  final int employeeEmpCode;
  final DateTime employeeDateOfJoining;
  final dynamic employeePhoto;
  final String employeePhone;
  final String employeeEmpStatus;
  final DateTime employeeCreatedAt;
  final dynamic employeeUpdatedAt;
  final String employeeIsActive;
  final int employeeUserId;
  final int employeeBranchId;
  final int employeeDepartmentId;
  final int employeeDesignationId;
  final int employeeEmployeeGradeId;
  final String role;
  final String email;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        employeeId: json["employee_id"],
        employeeName: json["employee_name"],
        employeeEmpCode: json["employee_emp_code"],
        employeeDateOfJoining: DateTime.parse(json["employee_date_of_joining"]),
        employeePhoto: json["employee_photo"],
        employeePhone: json["employee_phone"],
        employeeEmpStatus: json["employee_emp_status"],
        employeeCreatedAt: DateTime.parse(json["employee_created_at"]),
        employeeUpdatedAt: json["employee_updated_at"],
        employeeIsActive: json["employee_is_active"],
        employeeUserId: json["employee_user_id"],
        employeeBranchId: json["employee_branch_id"],
        employeeDepartmentId: json["employee_department_id"],
        employeeDesignationId: json["employee_designation_id"],
        employeeEmployeeGradeId: json["employee_employee_grade_id"],
        role: json["role"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "employee_name": employeeName,
        "employee_emp_code": employeeEmpCode,
        "employee_date_of_joining": employeeDateOfJoining.toIso8601String(),
        "employee_photo": employeePhoto,
        "employee_phone": employeePhone,
        "employee_emp_status": employeeEmpStatus,
        "employee_created_at": employeeCreatedAt.toIso8601String(),
        "employee_updated_at": employeeUpdatedAt,
        "employee_is_active": employeeIsActive,
        "employee_user_id": employeeUserId,
        "employee_branch_id": employeeBranchId,
        "employee_department_id": employeeDepartmentId,
        "employee_designation_id": employeeDesignationId,
        "employee_employee_grade_id": employeeEmployeeGradeId,
        "role": role,
        "email": email,
      };
}
