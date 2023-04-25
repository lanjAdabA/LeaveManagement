// To parse this JSON data, do
//
//     final leaveReportModel = leaveReportModelFromJson(jsonString);

import 'dart:convert';

List<LeaveReportModel> leaveReportModelFromJson(String str) =>
    List<LeaveReportModel>.from(
        json.decode(str).map((x) => LeaveReportModel.fromJson(x)));

String leaveReportModelToJson(List<LeaveReportModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveReportModel {
  LeaveReportModel({
    required this.id,
    required this.name,
    required this.gl,
    required this.lwp,
    required this.matl,
    required this.margl,
    required this.pt,
    required this.bl,
    required this.total,
  });

  int id;
  String name;
  String gl;
  String lwp;
  String matl;
  String margl;
  String pt;
  String bl;
  String total;

  factory LeaveReportModel.fromJson(Map<String, dynamic> json) =>
      LeaveReportModel(
        id: json["id"],
        name: json["name"],
        gl: json["gl"],
        lwp: json["lwp"],
        matl: json["matl"],
        margl: json["margl"],
        pt: json["pt"],
        bl: json["bl"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gl": gl,
        "lwp": lwp,
        "matl": matl,
        "margl": margl,
        "pt": pt,
        "bl": bl,
        "total": total,
      };
}
