// To parse this JSON data, do
//
//     final setAllowedUrlParam = setAllowedUrlParamFromJson(jsonString);

import 'dart:convert';

SetAllowedUrlParam setAllowedUrlParamFromJson(String str) =>
    SetAllowedUrlParam.fromJson(json.decode(str));

String setAllowedUrlParamToJson(SetAllowedUrlParam data) =>
    json.encode(data.toJson());

class SetAllowedUrlParam {
  String action;
  String id;
  String url;
  String accessTime;
  String roomId;

  SetAllowedUrlParam({
    required this.action,
    required this.id,
    required this.url,
    required this.accessTime,
    required this.roomId,
  });

  SetAllowedUrlParam copyWith({
    String? action,
    String? id,
    String? url,
    String? accessTime,
    String? roomId,
  }) =>
      SetAllowedUrlParam(
        action: action ?? this.action,
        id: id ?? this.id,
        url: url ?? this.url,
        accessTime: accessTime ?? this.accessTime,
        roomId: roomId ?? this.roomId,
      );

  factory SetAllowedUrlParam.fromJson(Map<String, dynamic> json) =>
      SetAllowedUrlParam(
        action: json["action"],
        id: json["id"],
        url: json["url"],
        accessTime: json["access_time"],
        roomId: json["room_id"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "id": id,
        "url": url,
        "access_time": accessTime,
        "room_id": roomId,
      };
}
