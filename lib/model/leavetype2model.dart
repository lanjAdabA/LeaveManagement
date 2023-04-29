// To parse this JSON data, do
//
//     final leaveType2Model = leaveType2ModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<LeaveType2Model> leaveType2ModelFromJson(String str) =>
    List<LeaveType2Model>.from(
        json.decode(str).map((x) => LeaveType2Model.fromJson(x)));

String leaveType2ModelToJson(List<LeaveType2Model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveType2Model {
  final int id;
  final String gender;
  final String name;
  final String? balance;
  final String canApply;
  final String? icon;

  LeaveType2Model({
    required this.id,
    required this.gender,
    required this.name,
    required this.balance,
    required this.canApply,
    required this.icon,
  });

  factory LeaveType2Model.fromJson(Map<String, dynamic> json) =>
      LeaveType2Model(
        id: json["id"],
        gender: json["gender"],
        name: json["name"],
        balance: json["balance"],
        canApply: json["can_apply"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender": gender,
        "name": name,
        "balance": balance,
        "can_apply": canApply,
        "icon": icon,
      };
}
