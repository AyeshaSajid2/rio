// To parse this JSON data, do
//
//     final getRoomListModel = getRoomListModelFromJson(jsonString);

import 'dart:convert';

GetRoomListModel getRoomListModelFromJson(String str) =>
    GetRoomListModel.fromJson(json.decode(str));

String getRoomListModelToJson(GetRoomListModel data) =>
    json.encode(data.toJson());

class GetRoomListModel {
  final String? status;
  final String? event;
  final String? time;
  final List<RoomListItem>? listOfRoom;

  GetRoomListModel({
    this.status,
    this.event,
    this.time,
    this.listOfRoom,
  });

  factory GetRoomListModel.fromJson(Map<String, dynamic> json) =>
      GetRoomListModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        listOfRoom: json["list"] == null
            ? []
            : List<RoomListItem>.from(
                json["list"]!.map((x) => RoomListItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "list": listOfRoom == null
            ? []
            : List<dynamic>.from(listOfRoom!.map((x) => x.toJson())),
      };
}

class RoomListItem {
  final String? id;
  final String? name;
  final String? nameEncode;
  final String? password;
  final String? ssidId;
  final String? ssidName;

  RoomListItem({
    this.id,
    this.name,
    this.nameEncode,
    this.password,
    this.ssidId,
    this.ssidName,
  });

  factory RoomListItem.fromJson(Map<String, dynamic> json) => RoomListItem(
        id: json["id"],
        name: json["name"],
        nameEncode: json["name_encode"],
        password: json["password"],
        ssidId: json["ssid_id"],
        ssidName: json["ssid_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_encode": nameEncode,
        "password": password,
        "ssid_id": ssidId,
        "ssid_name": ssidName,
      };
}
