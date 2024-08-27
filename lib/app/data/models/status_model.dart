// To parse this JSON data, do
//
//     final statusModel = statusModelFromJson(jsonString);

import 'dart:convert';

StatusModel statusModelFromJson(String str) =>
    StatusModel.fromJson(json.decode(str));

String statusModelToJson(StatusModel data) => json.encode(data.toJson());

class StatusModel {
  final String? status;
  final String? event;
  final String? time;

  StatusModel({
    this.status,
    this.event,
    this.time,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
      };
}
