// To parse this JSON data, do
//
//     final setDeviceAdminParam = setDeviceAdminParamFromJson(jsonString);

import 'dart:convert';

SetDeviceAdminParam setDeviceAdminParamFromJson(String str) =>
    SetDeviceAdminParam.fromJson(json.decode(str));

String setDeviceAdminParamToJson(SetDeviceAdminParam data) =>
    json.encode(data.toJson());

class SetDeviceAdminParam {
  String id;

  SetDeviceAdminParam({
    required this.id,
  });

  SetDeviceAdminParam copyWith({
    String? id,
  }) =>
      SetDeviceAdminParam(
        id: id ?? this.id,
      );

  factory SetDeviceAdminParam.fromJson(Map<String, dynamic> json) =>
      SetDeviceAdminParam(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
