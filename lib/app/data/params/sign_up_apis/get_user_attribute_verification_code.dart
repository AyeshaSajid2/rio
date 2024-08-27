// To parse this JSON data, do
//
//     final getUserAttributeVerificationCodeParam = getUserAttributeVerificationCodeParamFromJson(jsonString);

import 'dart:convert';

GetUserAttributeVerificationCodeParam
    getUserAttributeVerificationCodeParamFromJson(String str) =>
        GetUserAttributeVerificationCodeParam.fromJson(json.decode(str));

String getUserAttributeVerificationCodeParamToJson(
        GetUserAttributeVerificationCodeParam data) =>
    json.encode(data.toJson());

class GetUserAttributeVerificationCodeParam {
  String attributeName;
  String accessToken;

  GetUserAttributeVerificationCodeParam({
    required this.attributeName,
    required this.accessToken,
  });

  GetUserAttributeVerificationCodeParam copyWith({
    String? attributeName,
    String? accessToken,
  }) =>
      GetUserAttributeVerificationCodeParam(
        attributeName: attributeName ?? this.attributeName,
        accessToken: accessToken ?? this.accessToken,
      );

  factory GetUserAttributeVerificationCodeParam.fromJson(
          Map<String, dynamic> json) =>
      GetUserAttributeVerificationCodeParam(
        attributeName: json["AttributeName"],
        accessToken: json["AccessToken"],
      );

  Map<String, dynamic> toJson() => {
        "AttributeName": attributeName,
        "AccessToken": accessToken,
      };
}
