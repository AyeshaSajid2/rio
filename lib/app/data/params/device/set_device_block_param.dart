// To parse this JSON data, do
//
//     final setDeviceBlockParam = setDeviceBlockParamFromJson(jsonString);

import 'dart:convert';

SetDeviceBlockParam setDeviceBlockParamFromJson(String str) =>
    SetDeviceBlockParam.fromJson(json.decode(str));

String setDeviceBlockParamToJson(SetDeviceBlockParam data) =>
    json.encode(data.toJson());

class SetDeviceBlockParam {
  String id;
  String status;

  SetDeviceBlockParam({
    required this.id,
    required this.status,
  });

  SetDeviceBlockParam copyWith({
    String? id,
    String? status,
  }) =>
      SetDeviceBlockParam(
        id: id ?? this.id,
        status: status ?? this.status,
      );

  factory SetDeviceBlockParam.fromJson(Map<String, dynamic> json) =>
      SetDeviceBlockParam(
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
}
