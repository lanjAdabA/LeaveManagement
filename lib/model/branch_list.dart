// To parse this JSON data, do
//
//     final allBranchList = allBranchListFromJson(jsonString);

import 'dart:convert';

List<AllBranchList> allBranchListFromJson(String str) =>
    List<AllBranchList>.from(
        json.decode(str).map((x) => AllBranchList.fromJson(x)));

String allBranchListToJson(List<AllBranchList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllBranchList {
  AllBranchList({
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

  factory AllBranchList.fromJson(Map<String, dynamic> json) => AllBranchList(
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
