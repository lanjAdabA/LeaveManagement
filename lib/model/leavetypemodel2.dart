// To parse this JSON data, do
//
//     final getallLeavetype2Model = getallLeavetype2ModelFromJson(jsonString);

import 'dart:convert';

List<GetallLeavetype2Model> getallLeavetype2ModelFromJson(String str) =>
    List<GetallLeavetype2Model>.from(
        json.decode(str).map((x) => GetallLeavetype2Model.fromJson(x)));

String getallLeavetype2ModelToJson(List<GetallLeavetype2Model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetallLeavetype2Model {
  GetallLeavetype2Model({
    required this.id,
    required this.name,
    required this.description,
    required this.minimumDaysBefore,
    required this.credit,
    required this.isActive,
    required this.icon,
    required this.hidden,
    required this.applyToGender,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String? description;
  final int minimumDaysBefore;
  final String credit;
  final String isActive;
  final dynamic icon;
  final int hidden;
  final String applyToGender;
  final DateTime createdAt;
  final dynamic updatedAt;

  factory GetallLeavetype2Model.fromJson(Map<String, dynamic> json) =>
      GetallLeavetype2Model(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        minimumDaysBefore: json["minimum_days_before"],
        credit: json["credit"],
        isActive: json["is_active"],
        icon: json["icon"],
        hidden: json["hidden"],
        applyToGender: json["apply_to_gender"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "minimum_days_before": minimumDaysBefore,
        "credit": credit,
        "is_active": isActive,
        "icon": icon,
        "hidden": hidden,
        "apply_to_gender": applyToGender,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}
