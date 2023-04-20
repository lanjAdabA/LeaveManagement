// To parse this JSON data, do
//
//     final allDesignModel = allDesignModelFromJson(jsonString);

import 'dart:convert';

List<AllDesignModel> allDesignModelFromJson(String str) =>
    List<AllDesignModel>.from(
        json.decode(str).map((x) => AllDesignModel.fromJson(x)));

String allDesignModelToJson(List<AllDesignModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllDesignModel {
  AllDesignModel({
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

  factory AllDesignModel.fromJson(Map<String, dynamic> json) => AllDesignModel(
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
