// To parse this JSON data, do
//
//     final getDeviceListParam = getDeviceListParamFromJson(jsonString);

import 'dart:convert';

GetDeviceListParam getDeviceListParamFromJson(String str) =>
    GetDeviceListParam.fromJson(json.decode(str));

String getDeviceListParamToJson(GetDeviceListParam data) =>
    json.encode(data.toJson());

class GetDeviceListParam {
  String id;
  String type;

  GetDeviceListParam({
    required this.id,
    required this.type,
  });

  GetDeviceListParam copyWith({
    String? id,
    String? type,
  }) =>
      GetDeviceListParam(
        id: id ?? this.id,
        type: type ?? this.type,
      );

  factory GetDeviceListParam.fromJson(Map<String, dynamic> json) =>
      GetDeviceListParam(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}
