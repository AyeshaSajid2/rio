// To parse this JSON data, do
//
//     final getSystemSettingModel = getSystemSettingModelFromJson(jsonString);

import 'dart:convert';

GetSystemSettingModel getSystemSettingModelFromJson(String str) =>
    GetSystemSettingModel.fromJson(json.decode(str));

String getSystemSettingModelToJson(GetSystemSettingModel data) =>
    json.encode(data.toJson());

class GetSystemSettingModel {
  final String? status;
  final String? event;
  final String? time;
  final String? internetStatus;
  final String? firmwareVersion;
  final String? adminPassword;
  final String? timeZone;
  final String? timeLocation;

  GetSystemSettingModel({
    this.status,
    this.event,
    this.time,
    this.internetStatus,
    this.firmwareVersion,
    this.adminPassword,
    this.timeZone,
    this.timeLocation,
  });

  factory GetSystemSettingModel.fromJson(Map<String, dynamic> json) =>
      GetSystemSettingModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        internetStatus: json["internet_status"],
        firmwareVersion: json["firmware_version"],
        adminPassword: json["admin_password"],
        timeZone: json["time_zone"],
        timeLocation: json["time_location"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "internet_status": internetStatus,
        "firmware_version": firmwareVersion,
        "admin_password": adminPassword,
        "time_zone": timeZone,
        "time_location": timeLocation,
      };
}
