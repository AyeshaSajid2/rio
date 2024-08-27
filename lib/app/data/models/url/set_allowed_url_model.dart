// To parse this JSON data, do
//
//     final setAllowedUrlModel = setAllowedUrlModelFromJson(jsonString);

import 'dart:convert';

SetAllowedUrlModel setAllowedUrlModelFromJson(String str) =>
    SetAllowedUrlModel.fromJson(json.decode(str));

String setAllowedUrlModelToJson(SetAllowedUrlModel data) =>
    json.encode(data.toJson());

class SetAllowedUrlModel {
  final String? status;
  final String? event;
  final String? time;
  final String? id;

  SetAllowedUrlModel({
    this.status,
    this.event,
    this.time,
    this.id,
  });

  factory SetAllowedUrlModel.fromJson(Map<String, dynamic> json) =>
      SetAllowedUrlModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "id": id,
      };
}
