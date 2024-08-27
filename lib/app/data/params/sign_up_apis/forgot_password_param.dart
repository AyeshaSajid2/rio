// To parse this JSON data, do
//
//     final forgotPasswordParam = forgotPasswordParamFromJson(jsonString);

import 'dart:convert';

ForgotPasswordParam forgotPasswordParamFromJson(String str) =>
    ForgotPasswordParam.fromJson(json.decode(str));

String forgotPasswordParamToJson(ForgotPasswordParam data) =>
    json.encode(data.toJson());

class ForgotPasswordParam {
  String username;
  String secretHash;
  String clientId;

  ForgotPasswordParam({
    required this.username,
    required this.secretHash,
    required this.clientId,
  });

  ForgotPasswordParam copyWith({
    String? username,
    String? secretHash,
    String? clientId,
  }) =>
      ForgotPasswordParam(
        username: username ?? this.username,
        secretHash: secretHash ?? this.secretHash,
        clientId: clientId ?? this.clientId,
      );

  factory ForgotPasswordParam.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordParam(
        username: json["Username"],
        secretHash: json["SecretHash"],
        clientId: json["ClientId"],
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "SecretHash": secretHash,
        "ClientId": clientId,
      };
}
