// To parse this JSON data, do
//
//     final getRoomListParam = getRoomListParamFromJson(jsonString);

import 'dart:convert';

GetRoomListParam getRoomListParamFromJson(String str) =>
    GetRoomListParam.fromJson(json.decode(str));

String getRoomListParamToJson(GetRoomListParam data) =>
    json.encode(data.toJson());

class GetRoomListParam {
  String type;
  String id;

  GetRoomListParam({
    required this.type,
    required this.id,
  });

  GetRoomListParam copyWith({
    String? type,
    String? id,
  }) =>
      GetRoomListParam(
        type: type ?? this.type,
        id: id ?? this.id,
      );

  factory GetRoomListParam.fromJson(Map<String, dynamic> json) =>
      GetRoomListParam(
        type: json["type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
      };
}
