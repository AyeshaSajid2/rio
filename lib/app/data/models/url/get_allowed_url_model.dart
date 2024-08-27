// To parse this JSON data, do
//
//     final getAllowedUrlModel = getAllowedUrlModelFromJson(jsonString);

import 'dart:convert';

GetAllowedUrlModel getAllowedUrlModelFromJson(String str) =>
    GetAllowedUrlModel.fromJson(json.decode(str));

String getAllowedUrlModelToJson(GetAllowedUrlModel data) =>
    json.encode(data.toJson());

class GetAllowedUrlModel {
  final String? status;
  final String? event;
  final String? time;
  final String? id;
  final String? url;
  final String? accessTime;
  final String? roomId;

  GetAllowedUrlModel({
    this.status,
    this.event,
    this.time,
    this.id,
    this.url,
    this.accessTime,
    this.roomId,
  });

  factory GetAllowedUrlModel.fromJson(Map<String, dynamic> json) =>
      GetAllowedUrlModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        id: json["id"],
        url: json["url"],
        accessTime: json["access_time"],
        roomId: json["room_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "id": id,
        "url": url,
        "access_time": accessTime,
        "room_id": roomId,
      };
}
