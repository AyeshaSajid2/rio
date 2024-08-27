// To parse this JSON data, do
//
//     final confirmForgotPasswordParam = confirmForgotPasswordParamFromJson(jsonString);

import 'dart:convert';

ConfirmForgotPasswordParam confirmForgotPasswordParamFromJson(String str) =>
    ConfirmForgotPasswordParam.fromJson(json.decode(str));

String confirmForgotPasswordParamToJson(ConfirmForgotPasswordParam data) =>
    json.encode(data.toJson());

class ConfirmForgotPasswordParam {
  String username;
  String secretHash;
  String clientId;
  String confirmationCode;
  String password;

  ConfirmForgotPasswordParam({
    required this.username,
    required this.secretHash,
    required this.clientId,
    required this.confirmationCode,
    required this.password,
  });

  ConfirmForgotPasswordParam copyWith({
    String? username,
    String? secretHash,
    String? clientId,
    String? confirmationCode,
    String? password,
  }) =>
      ConfirmForgotPasswordParam(
        username: username ?? this.username,
        secretHash: secretHash ?? this.secretHash,
        clientId: clientId ?? this.clientId,
        confirmationCode: confirmationCode ?? this.confirmationCode,
        password: password ?? this.password,
      );

  factory ConfirmForgotPasswordParam.fromJson(Map<String, dynamic> json) =>
      ConfirmForgotPasswordParam(
        username: json["Username"],
        secretHash: json["SecretHash"],
        clientId: json["ClientId"],
        confirmationCode: json["ConfirmationCode"],
        password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "SecretHash": secretHash,
        "ClientId": clientId,
        "ConfirmationCode": confirmationCode,
        "Password": password,
      };
}
