// To parse this JSON data, do
//
//     final getWifiParam = getWifiParamFromJson(jsonString);

import 'dart:convert';

GetWifiParam getWifiParamFromJson(String str) =>
    GetWifiParam.fromJson(json.decode(str));

String getWifiParamToJson(GetWifiParam data) => json.encode(data.toJson());

class GetWifiParam {
  String id;

  GetWifiParam({
    required this.id,
  });

  GetWifiParam copyWith({
    String? id,
  }) =>
      GetWifiParam(
        id: id ?? this.id,
      );

  factory GetWifiParam.fromJson(Map<String, dynamic> json) => GetWifiParam(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
