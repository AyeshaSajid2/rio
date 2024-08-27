// To parse this JSON data, do
//
//     final initAuthModel = initAuthModelFromJson(jsonString);

import 'dart:convert';

InitAuthModel initAuthModelFromJson(String str) =>
    InitAuthModel.fromJson(json.decode(str));

String initAuthModelToJson(InitAuthModel data) => json.encode(data.toJson());

class InitAuthModel {
  final AuthenticationResult? authenticationResult;
  final ChallengeParameters? challengeParameters;

  InitAuthModel({
    this.authenticationResult,
    this.challengeParameters,
  });

  factory InitAuthModel.fromJson(Map<String, dynamic> json) => InitAuthModel(
        authenticationResult: json["AuthenticationResult"] == null
            ? null
            : AuthenticationResult.fromJson(json["AuthenticationResult"]),
        challengeParameters: json["ChallengeParameters"] == null
            ? null
            : ChallengeParameters.fromJson(json["ChallengeParameters"]),
      );

  Map<String, dynamic> toJson() => {
        "AuthenticationResult": authenticationResult?.toJson(),
        "ChallengeParameters": challengeParameters?.toJson(),
      };
}

class AuthenticationResult {
  final String? accessToken;
  final int? expiresIn;
  final String? idToken;
  final String? refreshToken;
  final String? tokenType;

  AuthenticationResult({
    this.accessToken,
    this.expiresIn,
    this.idToken,
    this.refreshToken,
    this.tokenType,
  });

  factory AuthenticationResult.fromJson(Map<String, dynamic> json) =>
      AuthenticationResult(
        accessToken: json["AccessToken"],
        expiresIn: json["ExpiresIn"],
        idToken: json["IdToken"],
        refreshToken: json["RefreshToken"],
        tokenType: json["TokenType"],
      );

  Map<String, dynamic> toJson() => {
        "AccessToken": accessToken,
        "ExpiresIn": expiresIn,
        "IdToken": idToken,
        "RefreshToken": refreshToken,
        "TokenType": tokenType,
      };
}

class ChallengeParameters {
  ChallengeParameters();

  factory ChallengeParameters.fromJson(Map<String, dynamic> json) =>
      ChallengeParameters();

  Map<String, dynamic> toJson() => {};
}
