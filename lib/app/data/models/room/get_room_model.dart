// To parse this JSON data, do
//
//     final getRoomModel = getRoomModelFromJson(jsonString);

import 'dart:convert';

GetRoomModel getRoomModelFromJson(String str) =>
    GetRoomModel.fromJson(json.decode(str));

String getRoomModelToJson(GetRoomModel data) => json.encode(data.toJson());

class GetRoomModel {
  final String? status;
  final String? event;
  final String? time;
  final String? id;
  final String? name;
  final String? nameEncode;
  final String? password;
  final String? parentalControl;
  final String? ssidId;
  final String? ssidName;
  final String? vpnId;
  final String? roomStatus;
  final String? accessList;

  GetRoomModel({
    this.status,
    this.event,
    this.time,
    this.id,
    this.name,
    this.nameEncode,
    this.password,
    this.parentalControl,
    this.ssidId,
    this.ssidName,
    this.vpnId,
    this.roomStatus,
    this.accessList,
  });

  factory GetRoomModel.fromJson(Map<String, dynamic> json) => GetRoomModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        id: json["id"],
        name: json["name"],
        nameEncode: json["name_encode"],
        password: json["password"],
        parentalControl: json["parental_control"],
        ssidId: json["ssid_id"],
        ssidName: json["ssid_name"],
        vpnId: json["vpn_id"],
        roomStatus: json["room_status"],
        accessList: json["access_list"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "id": id,
        "name": name,
        "name_encode": nameEncode,
        "password": password,
        "parental_control": parentalControl,
        "ssid_id": ssidId,
        "ssid_name": ssidName,
        "vpn_id": vpnId,
        "room_status": roomStatus,
        "access_list": accessList,
      };
}
