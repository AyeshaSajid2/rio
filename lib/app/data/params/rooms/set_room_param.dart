// To parse this JSON data, do
//
//     final setRoomParam = setRoomParamFromJson(jsonString);

import 'dart:convert';

SetRoomParam setRoomParamFromJson(String str) =>
    SetRoomParam.fromJson(json.decode(str));

String setRoomParamToJson(SetRoomParam data) => json.encode(data.toJson());

class SetRoomParam {
  String action;
  String id;
  String nameEncode;
  String password;
  String parentalControl;
  String ssidId;
  String vpnId;
  String roomStatus;

  SetRoomParam({
    required this.action,
    required this.id,
    required this.nameEncode,
    required this.password,
    required this.parentalControl,
    required this.ssidId,
    required this.vpnId,
    required this.roomStatus,
  });

  SetRoomParam copyWith({
    String? action,
    String? id,
    String? nameEncode,
    String? password,
    String? parentalControl,
    String? ssidId,
    String? vpnId,
    String? roomStatus,
  }) =>
      SetRoomParam(
        action: action ?? this.action,
        id: id ?? this.id,
        nameEncode: nameEncode ?? this.nameEncode,
        password: password ?? this.password,
        parentalControl: parentalControl ?? this.parentalControl,
        ssidId: ssidId ?? this.ssidId,
        vpnId: vpnId ?? this.vpnId,
        roomStatus: roomStatus ?? this.roomStatus,
      );

  factory SetRoomParam.fromJson(Map<String, dynamic> json) => SetRoomParam(
        action: json["action"],
        id: json["id"],
        nameEncode: json["name_encode"],
        password: json["password"],
        parentalControl: json["parental_control"],
        ssidId: json["ssid_id"],
        vpnId: json["vpn_id"],
        roomStatus: json["room_status"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "id": id,
        "name_encode": nameEncode,
        "password": password,
        "parental_control": parentalControl,
        "ssid_id": ssidId,
        "vpn_id": vpnId,
        "room_status": roomStatus,
      };
}
