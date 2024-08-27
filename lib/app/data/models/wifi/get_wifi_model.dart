// To parse this JSON data, do
//
//     final getWifiModel = getWifiModelFromJson(jsonString);

import 'dart:convert';

GetWifiModel getWifiModelFromJson(String str) =>
    GetWifiModel.fromJson(json.decode(str));

String getWifiModelToJson(GetWifiModel data) => json.encode(data.toJson());

class GetWifiModel {
  final String? status;
  final String? event;
  final String? time;
  final String? id;
  late final String? name;
  final String? ssidStatus;
  late final String? password;
  final String? broadcast;
  final String? frequency;
  final String? security;
  final String? encryption;

  GetWifiModel({
    this.status,
    this.event,
    this.time,
    this.id,
    this.name,
    this.ssidStatus,
    this.password,
    this.broadcast,
    this.frequency,
    this.security,
    this.encryption,
  });

  factory GetWifiModel.fromJson(Map<String, dynamic> json) => GetWifiModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        id: json["id"],
        name: json["name"],
        ssidStatus: json["ssid_status"],
        password: json["password"],
        broadcast: json["broadcast"],
        frequency: json["frequency"],
        security: json["security"],
        encryption: json["encryption"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "id": id,
        "name": name,
        "ssid_status": ssidStatus,
        "password": password,
        "broadcast": broadcast,
        "frequency": frequency,
        "security": security,
        "encryption": encryption,
      };
}
