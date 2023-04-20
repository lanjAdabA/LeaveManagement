// To parse this JSON data, do
//
//     final getallLeavetypeModel = getallLeavetypeModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

GetallLeavetypeModel getallLeavetypeModelFromJson(String str) =>
    GetallLeavetypeModel.fromJson(json.decode(str));

String getallLeavetypeModelToJson(GetallLeavetypeModel data) =>
    json.encode(data.toJson());

class GetallLeavetypeModel {
  GetallLeavetypeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final Data data;

  factory GetallLeavetypeModel.fromJson(Map<String, dynamic> json) =>
      GetallLeavetypeModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.leaves,
  });

  final List<Leaf> leaves;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        leaves: List<Leaf>.from(json["leaves"].map((x) => Leaf.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "leaves": List<dynamic>.from(leaves.map((x) => x.toJson())),
      };
}

class Leaf {
  Leaf({
    required this.id,
    required this.name,
    required this.balance,
    required this.canApply,
    required this.hidden,
    required this.icon,
  });

  final int id;
  final String name;
  final double balance;
  final String canApply;
  final bool hidden;
  final Icon? icon;

  factory Leaf.fromJson(Map<String, dynamic> json) => Leaf(
        id: json["id"],
        name: json["name"],
        balance: json["balance"],
        canApply: json["can_apply"],
        hidden: json["hidden"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "balance": balance,
        "can_apply": canApply,
        "hidden": hidden,
        "icon": icon,
      };
}
