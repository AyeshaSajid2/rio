// To parse this JSON data, do
//
//     final adminPasswordParam = adminPasswordParamFromJson(jsonString);

import 'dart:convert';

AdminPasswordParam adminPasswordParamFromJson(String str) =>
    AdminPasswordParam.fromJson(json.decode(str));

String adminPasswordParamToJson(AdminPasswordParam data) =>
    json.encode(data.toJson());

class AdminPasswordParam {
  String password;

  AdminPasswordParam({
    required this.password,
  });

  AdminPasswordParam copyWith({
    String? password,
  }) =>
      AdminPasswordParam(
        password: password ?? this.password,
      );

  factory AdminPasswordParam.fromJson(Map<String, dynamic> json) =>
      AdminPasswordParam(
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
      };
}
