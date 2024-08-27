// To parse this JSON data, do
//
//     final getDeviceListModel = getDeviceListModelFromJson(jsonString);

import 'dart:convert';

GetDeviceListModel getDeviceListModelFromJson(String str) =>
    GetDeviceListModel.fromJson(json.decode(str));

String getDeviceListModelToJson(GetDeviceListModel data) =>
    json.encode(data.toJson());

class GetDeviceListModel {
  final String? status;
  final String? event;
  final String? time;
  final List<DeviceListItem>? listOfDevices;

  GetDeviceListModel({
    this.status,
    this.event,
    this.time,
    this.listOfDevices,
  });

  factory GetDeviceListModel.fromJson(Map<String, dynamic> json) =>
      GetDeviceListModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        listOfDevices: json["list"] == null
            ? []
            : List<DeviceListItem>.from(
                json["list"]!.map((x) => DeviceListItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "list": listOfDevices == null
            ? []
            : List<dynamic>.from(listOfDevices!.map((x) => x.toJson())),
      };
}

class DeviceListItem {
  final int? id;
  final String? mac;
  final String? name;
  final String? status;
  final String? roomId;
  final String? roomName;
  final String? roomNameEncode;
  final String? ssidId;
  final String? ssidName;
  final String? block;
  final String? role;
  final String? labelEncode;
  final String? type;
  final String? brand;
  final String? model;
  final String? osName;
  final String? osVer;
  final String? destRoomId;
  final String? destRoomName;

  DeviceListItem({
    this.id,
    this.mac,
    this.name,
    this.status,
    this.roomId,
    this.roomName,
    this.roomNameEncode,
    this.ssidId,
    this.ssidName,
    this.block,
    this.role,
    this.labelEncode,
    this.type,
    this.brand,
    this.model,
    this.osName,
    this.osVer,
    this.destRoomId,
    this.destRoomName,
  });

  factory DeviceListItem.fromJson(Map<String, dynamic> json) => DeviceListItem(
        id: json["id"],
        mac: json["mac"],
        name: json["name"],
        status: json["status"],
        roomId: json["room_id"],
        roomName: json["room_name"],
        roomNameEncode: json["room_name_encode"],
        ssidId: json["ssid_id"],
        ssidName: json["ssid_name"],
        block: json["block"],
        role: json["role"],
        labelEncode: json["label_encode"],
        type: json["type"],
        brand: json["brand"],
        model: json["model"],
        osName: json["os-name"],
        osVer: json["os-ver"],
        destRoomId: json["dest_room_id"],
        destRoomName: json["dest_room_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mac": mac,
        "name": name,
        "status": status,
        "room_id": roomId,
        "room_name": roomName,
        "room_name_encode": roomNameEncode,
        "ssid_id": ssidId,
        "ssid_name": ssidName,
        "block": block,
        "role": role,
        "label_encode": labelEncode,
        "type": type,
        "brand": brand,
        "model": model,
        "os-name": osName,
        "os-ver": osVer,
        "dest_room_id": destRoomId,
        "dest_room_name": destRoomName,
      };
}
