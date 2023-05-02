// To parse this JSON data, do
//
//     final leaveReportModel = leaveReportModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<LeaveReportModel> leaveReportModelFromJson(String str) =>
    List<LeaveReportModel>.from(
        json.decode(str).map((x) => LeaveReportModel.fromJson(x)));

String leaveReportModelToJson(List<LeaveReportModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveReportModel {
  final int id;
  final String name;
  final String general;
  final String lwp;
  final String matl;
  final String margl;
  final String pt;
  final String bl;
  final String total;

  LeaveReportModel({
    required this.id,
    required this.name,
    required this.general,
    required this.lwp,
    required this.matl,
    required this.margl,
    required this.pt,
    required this.bl,
    required this.total,
  });

  factory LeaveReportModel.fromJson(Map<String, dynamic> json) =>
      LeaveReportModel(
        id: json["id"],
        name: json["name"],
        general: json["general"],
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
        "general": general,
        "lwp": lwp,
        "matl": matl,
        "margl": margl,
        "pt": pt,
        "bl": bl,
        "total": total,
      };
}
