// To parse this JSON data, do
//
//     final allRoleModel = allRoleModelFromJson(jsonString);

import 'dart:convert';

List<AllRoleModel> allRoleModelFromJson(String str) => List<AllRoleModel>.from(
    json.decode(str).map((x) => AllRoleModel.fromJson(x)));

String allRoleModelToJson(List<AllRoleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllRoleModel {
  AllRoleModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final dynamic description;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory AllRoleModel.fromJson(Map<String, dynamic> json) => AllRoleModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
