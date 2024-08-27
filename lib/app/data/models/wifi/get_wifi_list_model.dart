// To parse this JSON data, do
//
//     final getWifiListModel = getWifiListModelFromJson(jsonString);

import 'dart:convert';

GetWifiListModel getWifiListModelFromJson(String str) =>
    GetWifiListModel.fromJson(json.decode(str));

String getWifiListModelToJson(GetWifiListModel data) =>
    json.encode(data.toJson());

class GetWifiListModel {
  final String? status;
  final String? event;
  final String? time;
  final List<WifiElement>? listOfWifi;

  GetWifiListModel({
    this.status,
    this.event,
    this.time,
    this.listOfWifi,
  });

  factory GetWifiListModel.fromJson(Map<String, dynamic> json) =>
      GetWifiListModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        listOfWifi: json["list"] == null
            ? []
            : List<WifiElement>.from(
                json["list"]!.map((x) => WifiElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "list": listOfWifi == null
            ? []
            : List<dynamic>.from(listOfWifi!.map((x) => x.toJson())),
      };
}

class WifiElement {
  final String? id;
  final String? name;
  final String? status;
  final String? password;
  final String? broadcast;
  final String? frequency;
  final String? security;
  final String? encryption;

  WifiElement({
    this.id,
    this.name,
    this.status,
    this.password,
    this.broadcast,
    this.frequency,
    this.security,
    this.encryption,
  });

  factory WifiElement.fromJson(Map<String, dynamic> json) => WifiElement(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        password: json["password"],
        broadcast: json["broadcast"],
        frequency: json["frequency"],
        security: json["security"],
        encryption: json["encryption"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "password": password,
        "broadcast": broadcast,
        "frequency": frequency,
        "security": security,
        "encryption": encryption,
      };
}
