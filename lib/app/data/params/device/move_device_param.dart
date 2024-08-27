// To parse this JSON data, do
//
//     final moveDeviceParam = moveDeviceParamFromJson(jsonString);

import 'dart:convert';

MoveDeviceParam moveDeviceParamFromJson(String str) =>
    MoveDeviceParam.fromJson(json.decode(str));

String moveDeviceParamToJson(MoveDeviceParam data) =>
    json.encode(data.toJson());

class MoveDeviceParam {
  String deviceId;
  String roomId;

  MoveDeviceParam({
    required this.deviceId,
    required this.roomId,
  });

  MoveDeviceParam copyWith({
    String? deviceId,
    String? roomId,
  }) =>
      MoveDeviceParam(
        deviceId: deviceId ?? this.deviceId,
        roomId: roomId ?? this.roomId,
      );

  factory MoveDeviceParam.fromJson(Map<String, dynamic> json) =>
      MoveDeviceParam(
        deviceId: json["device_id"],
        roomId: json["room_id"],
      );

  Map<String, dynamic> toJson() => {
        "device_id": deviceId,
        "room_id": roomId,
      };
}
