// To parse this JSON data, do
//
//     final allDeptListModel = allDeptListModelFromJson(jsonString);

import 'dart:convert';

List<AllDeptListModel> allDeptListModelFromJson(String str) =>
    List<AllDeptListModel>.from(
        json.decode(str).map((x) => AllDeptListModel.fromJson(x)));

String allDeptListModelToJson(List<AllDeptListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllDeptListModel {
  AllDeptListModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  final int id;
  final String name;
  final DateTime createdAt;
  final dynamic updatedAt;
  final String isActive;

  factory AllDeptListModel.fromJson(Map<String, dynamic> json) =>
      AllDeptListModel(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "is_active": isActive,
      };
}
