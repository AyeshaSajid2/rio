// To parse this JSON data, do
//
//     final confirmUserSignUpParam = confirmUserSignUpParamFromJson(jsonString);

import 'dart:convert';

ConfirmUserSignUpParam confirmUserSignUpParamFromJson(String str) =>
    ConfirmUserSignUpParam.fromJson(json.decode(str));

String confirmUserSignUpParamToJson(ConfirmUserSignUpParam data) =>
    json.encode(data.toJson());

class ConfirmUserSignUpParam {
  String username;
  String secretHash;
  String clientId;
  String confirmationCode;

  ConfirmUserSignUpParam({
    required this.username,
    required this.secretHash,
    required this.clientId,
    required this.confirmationCode,
  });

  ConfirmUserSignUpParam copyWith({
    String? username,
    String? secretHash,
    String? clientId,
    String? confirmationCode,
  }) =>
      ConfirmUserSignUpParam(
        username: username ?? this.username,
        secretHash: secretHash ?? this.secretHash,
        clientId: clientId ?? this.clientId,
        confirmationCode: confirmationCode ?? this.confirmationCode,
      );

  factory ConfirmUserSignUpParam.fromJson(Map<String, dynamic> json) =>
      ConfirmUserSignUpParam(
        username: json["Username"],
        secretHash: json["SecretHash"],
        clientId: json["ClientId"],
        confirmationCode: json["ConfirmationCode"],
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "SecretHash": secretHash,
        "ClientId": clientId,
        "ConfirmationCode": confirmationCode,
      };
}
