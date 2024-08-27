// To parse this JSON data, do
//
//     final getRoomParam = getRoomParamFromJson(jsonString);

import 'dart:convert';

GetRoomParam getRoomParamFromJson(String str) =>
    GetRoomParam.fromJson(json.decode(str));

String getRoomParamToJson(GetRoomParam data) => json.encode(data.toJson());

class GetRoomParam {
  String id;

  GetRoomParam({
    required this.id,
  });

  GetRoomParam copyWith({
    String? id,
  }) =>
      GetRoomParam(
        id: id ?? this.id,
      );

  factory GetRoomParam.fromJson(Map<String, dynamic> json) => GetRoomParam(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
