// To parse this JSON data, do
//
//     final getAllowedUrlParam = getAllowedUrlParamFromJson(jsonString);

import 'dart:convert';

GetAllowedUrlParam getAllowedUrlParamFromJson(String str) =>
    GetAllowedUrlParam.fromJson(json.decode(str));

String getAllowedUrlParamToJson(GetAllowedUrlParam data) =>
    json.encode(data.toJson());

class GetAllowedUrlParam {
  String id;

  GetAllowedUrlParam({
    required this.id,
  });

  GetAllowedUrlParam copyWith({
    String? id,
  }) =>
      GetAllowedUrlParam(
        id: id ?? this.id,
      );

  factory GetAllowedUrlParam.fromJson(Map<String, dynamic> json) =>
      GetAllowedUrlParam(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
