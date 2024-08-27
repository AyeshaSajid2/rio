// To parse this JSON data, do
//
//     final getAllowedUrlListParam = getAllowedUrlListParamFromJson(jsonString);

import 'dart:convert';

GetAllowedUrlListParam getAllowedUrlListParamFromJson(String str) =>
    GetAllowedUrlListParam.fromJson(json.decode(str));

String getAllowedUrlListParamToJson(GetAllowedUrlListParam data) =>
    json.encode(data.toJson());

class GetAllowedUrlListParam {
  String id;

  GetAllowedUrlListParam({
    required this.id,
  });

  GetAllowedUrlListParam copyWith({
    String? id,
  }) =>
      GetAllowedUrlListParam(
        id: id ?? this.id,
      );

  factory GetAllowedUrlListParam.fromJson(Map<String, dynamic> json) =>
      GetAllowedUrlListParam(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
