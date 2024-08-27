// To parse this JSON data, do
//
//     final getFirmwareVersionModel = getFirmwareVersionModelFromJson(jsonString);

import 'dart:convert';

GetFirmwareVersionModel getFirmwareVersionModelFromJson(String str) =>
    GetFirmwareVersionModel.fromJson(json.decode(str));

String getFirmwareVersionModelToJson(GetFirmwareVersionModel data) =>
    json.encode(data.toJson());

class GetFirmwareVersionModel {
  final String? status;
  final String? event;
  final String? time;
  final String? firmwareVersion;

  GetFirmwareVersionModel({
    this.status,
    this.event,
    this.time,
    this.firmwareVersion,
  });

  factory GetFirmwareVersionModel.fromJson(Map<String, dynamic> json) =>
      GetFirmwareVersionModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        firmwareVersion: json["firmware_version"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "firmware_version": firmwareVersion,
      };
}
