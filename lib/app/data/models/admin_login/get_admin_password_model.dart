// To parse this JSON data, do
//
//     final getAdminPasswordModel = getAdminPasswordModelFromJson(jsonString);

import 'dart:convert';

GetAdminPasswordModel getAdminPasswordModelFromJson(String str) =>
    GetAdminPasswordModel.fromJson(json.decode(str));

String getAdminPasswordModelToJson(GetAdminPasswordModel data) =>
    json.encode(data.toJson());

class GetAdminPasswordModel {
  final String? status;
  final String? event;
  final String? time;
  final String? adminPassword;
  final String? changed;

  GetAdminPasswordModel({
    this.status,
    this.event,
    this.time,
    this.adminPassword,
    this.changed,
  });

  factory GetAdminPasswordModel.fromJson(Map<String, dynamic> json) =>
      GetAdminPasswordModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        adminPassword: json["password"],
        changed: json["changed"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "password": adminPassword,
        "changed": changed,
      };
}
