// To parse this JSON data, do
//
//     final setRoomModel = setRoomModelFromJson(jsonString);

import 'dart:convert';

SetRoomModel setRoomModelFromJson(String str) =>
    SetRoomModel.fromJson(json.decode(str));

String setRoomModelToJson(SetRoomModel data) => json.encode(data.toJson());

class SetRoomModel {
  final String? status;
  final String? event;
  final String? time;
  final String? id;

  SetRoomModel({
    this.status,
    this.event,
    this.time,
    this.id,
  });

  factory SetRoomModel.fromJson(Map<String, dynamic> json) => SetRoomModel(
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
