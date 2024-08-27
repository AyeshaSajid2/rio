// To parse this JSON data, do
//
//     final deleteDeviceParam = deleteDeviceParamFromJson(jsonString);

import 'dart:convert';

DeleteDeviceParam deleteDeviceParamFromJson(String str) =>
    DeleteDeviceParam.fromJson(json.decode(str));

String deleteDeviceParamToJson(DeleteDeviceParam data) =>
    json.encode(data.toJson());

class DeleteDeviceParam {
  String id;

  DeleteDeviceParam({
    required this.id,
  });

  DeleteDeviceParam copyWith({
    String? id,
  }) =>
      DeleteDeviceParam(
        id: id ?? this.id,
      );

  factory DeleteDeviceParam.fromJson(Map<String, dynamic> json) =>
      DeleteDeviceParam(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
