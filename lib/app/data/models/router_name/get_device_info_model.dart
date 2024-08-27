// To parse this JSON data, do
//
//     final getDeviceInfoModel = getDeviceInfoModelFromJson(jsonString);

import 'dart:convert';

GetDeviceInfoModel getDeviceInfoModelFromJson(String str) =>
    GetDeviceInfoModel.fromJson(json.decode(str));

String getDeviceInfoModelToJson(GetDeviceInfoModel data) =>
    json.encode(data.toJson());

class GetDeviceInfoModel {
  final String? status;
  final String? event;
  final String? time;
  final String? serialNumber;
  final String? modelName;
  final String? hardwareVersion;
  final String? manufacturer;

  GetDeviceInfoModel({
    this.status,
    this.event,
    this.time,
    this.serialNumber,
    this.modelName,
    this.hardwareVersion,
    this.manufacturer,
  });

  factory GetDeviceInfoModel.fromJson(Map<String, dynamic> json) =>
      GetDeviceInfoModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        serialNumber: json["serial_number"],
        modelName: json["model_name"],
        hardwareVersion: json["hardware_version"],
        manufacturer: json["manufacturer"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "serial_number": serialNumber,
        "model_name": modelName,
        "hardware_version": hardwareVersion,
        "manufacturer": manufacturer,
      };
}
