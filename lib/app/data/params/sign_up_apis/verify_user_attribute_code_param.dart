// To parse this JSON data, do
//
//     final verifyUserAttributeCodeParam = verifyUserAttributeCodeParamFromJson(jsonString);

import 'dart:convert';

VerifyUserAttributeCodeParam verifyUserAttributeCodeParamFromJson(String str) =>
    VerifyUserAttributeCodeParam.fromJson(json.decode(str));

String verifyUserAttributeCodeParamToJson(VerifyUserAttributeCodeParam data) =>
    json.encode(data.toJson());

class VerifyUserAttributeCodeParam {
  String attributeName;
  String code;
  String accessToken;

  VerifyUserAttributeCodeParam({
    required this.attributeName,
    required this.code,
    required this.accessToken,
  });

  VerifyUserAttributeCodeParam copyWith({
    String? attributeName,
    String? code,
    String? accessToken,
  }) =>
      VerifyUserAttributeCodeParam(
        attributeName: attributeName ?? this.attributeName,
        code: code ?? this.code,
        accessToken: accessToken ?? this.accessToken,
      );

  factory VerifyUserAttributeCodeParam.fromJson(Map<String, dynamic> json) =>
      VerifyUserAttributeCodeParam(
        attributeName: json["AttributeName"],
        code: json["Code"],
        accessToken: json["AccessToken"],
      );

  Map<String, dynamic> toJson() => {
        "AttributeName": attributeName,
        "Code": code,
        "AccessToken": accessToken,
      };
}
