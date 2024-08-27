// To parse this JSON data, do
//
//     final setWifiParam = setWifiParamFromJson(jsonString);

import 'dart:convert';

SetWifiParam setWifiParamFromJson(String str) =>
    SetWifiParam.fromJson(json.decode(str));

String setWifiParamToJson(SetWifiParam data) => json.encode(data.toJson());

class SetWifiParam {
  String action;
  String id;
  String name;
  String status;
  String password;
  String broadcast;

  SetWifiParam({
    required this.action,
    required this.id,
    required this.name,
    required this.status,
    required this.password,
    required this.broadcast,
  });

  SetWifiParam copyWith({
    String? action,
    String? id,
    String? name,
    String? status,
    String? password,
    String? broadcast,
  }) =>
      SetWifiParam(
        action: action ?? this.action,
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        password: password ?? this.password,
        broadcast: broadcast ?? this.broadcast,
      );

  factory SetWifiParam.fromJson(Map<String, dynamic> json) => SetWifiParam(
        action: json["action"],
        id: json["id"],
        name: json["name"],
        status: json["status"],
        password: json["password"],
        broadcast: json["broadcast"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "id": id,
        "name": name,
        "status": status,
        "password": password,
        "broadcast": broadcast,
      };
}
