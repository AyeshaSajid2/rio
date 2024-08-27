// To parse this JSON data, do
//
//     final getMeshModeModel = getMeshModeModelFromJson(jsonString);

import 'dart:convert';

GetMeshModeModel getMeshModeModelFromJson(String str) =>
    GetMeshModeModel.fromJson(json.decode(str));

String getMeshModeModelToJson(GetMeshModeModel data) =>
    json.encode(data.toJson());

class GetMeshModeModel {
  final String? status;
  final String? event;
  final String? time;
  final String? mode;

  GetMeshModeModel({
    this.status,
    this.event,
    this.time,
    this.mode,
  });

  factory GetMeshModeModel.fromJson(Map<String, dynamic> json) =>
      GetMeshModeModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        mode: json["mode"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "mode": mode,
      };
}
