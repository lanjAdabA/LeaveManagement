// To parse this JSON data, do
//
//     final verifymailmodel = verifymailmodelFromJson(jsonString);

import 'dart:convert';

Verifymailmodel verifymailmodelFromJson(String str) =>
    Verifymailmodel.fromJson(json.decode(str));

String verifymailmodelToJson(Verifymailmodel data) =>
    json.encode(data.toJson());

class Verifymailmodel {
  Verifymailmodel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final Data data;

  factory Verifymailmodel.fromJson(Map<String, dynamic> json) =>
      Verifymailmodel(
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
    required this.accessToken,
  });

  final String accessToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
      };
}
