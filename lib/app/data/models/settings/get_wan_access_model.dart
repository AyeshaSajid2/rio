// To parse this JSON data, do
//
//     final getWanAccessModel = getWanAccessModelFromJson(jsonString);

import 'dart:convert';

GetWanAccessModel getWanAccessModelFromJson(String str) =>
    GetWanAccessModel.fromJson(json.decode(str));

String getWanAccessModelToJson(GetWanAccessModel data) =>
    json.encode(data.toJson());

class GetWanAccessModel {
  final String? status;
  final String? event;
  final String? time;
  final String? wanAccess;
  final String? currentStatus;

  GetWanAccessModel({
    this.status,
    this.event,
    this.time,
    this.wanAccess,
    this.currentStatus,
  });

  factory GetWanAccessModel.fromJson(Map<String, dynamic> json) =>
      GetWanAccessModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        wanAccess: json["wan_access"],
        currentStatus: json["current_status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "wan_access": wanAccess,
        "current_status": currentStatus,
      };
}
