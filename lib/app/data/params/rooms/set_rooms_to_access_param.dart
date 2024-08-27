// To parse this JSON data, do
//
//     final setRoomsToRoomAccessParam = setRoomsToRoomAccessParamFromJson(jsonString);

import 'dart:convert';

SetRoomsToRoomAccessParam setRoomsToRoomAccessParamFromJson(String str) =>
    SetRoomsToRoomAccessParam.fromJson(json.decode(str));

String setRoomsToRoomAccessParamToJson(SetRoomsToRoomAccessParam data) =>
    json.encode(data.toJson());

class SetRoomsToRoomAccessParam {
  String id;
  String accessList;

  SetRoomsToRoomAccessParam({
    required this.id,
    required this.accessList,
  });

  SetRoomsToRoomAccessParam copyWith({
    String? id,
    String? accessList,
  }) =>
      SetRoomsToRoomAccessParam(
        id: id ?? this.id,
        accessList: accessList ?? this.accessList,
      );

  factory SetRoomsToRoomAccessParam.fromJson(Map<String, dynamic> json) =>
      SetRoomsToRoomAccessParam(
        id: json["id"],
        accessList: json["access_list"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "access_list": accessList,
      };
}
