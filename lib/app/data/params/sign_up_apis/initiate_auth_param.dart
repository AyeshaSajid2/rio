// To parse this JSON data, do
//
//     final initiateAuthParam = initiateAuthParamFromJson(jsonString);

import 'dart:convert';

InitiateAuthParam initiateAuthParamFromJson(String str) =>
    InitiateAuthParam.fromJson(json.decode(str));

String initiateAuthParamToJson(InitiateAuthParam data) =>
    json.encode(data.toJson());

class InitiateAuthParam {
  String authFlow;
  AuthParameters authParameters;
  String clientId;

  InitiateAuthParam({
    required this.authFlow,
    required this.authParameters,
    required this.clientId,
  });

  InitiateAuthParam copyWith({
    String? authFlow,
    AuthParameters? authParameters,
    String? clientId,
  }) =>
      InitiateAuthParam(
        authFlow: authFlow ?? this.authFlow,
        authParameters: authParameters ?? this.authParameters,
        clientId: clientId ?? this.clientId,
      );

  factory InitiateAuthParam.fromJson(Map<String, dynamic> json) =>
      InitiateAuthParam(
        authFlow: json["AuthFlow"],
        authParameters: AuthParameters.fromJson(json["AuthParameters"]),
        clientId: json["ClientId"],
      );

  Map<String, dynamic> toJson() => {
        "AuthFlow": authFlow,
        "AuthParameters": authParameters.toJson(),
        "ClientId": clientId,
      };
}

class AuthParameters {
  String username;
  String password;
  String secretHash;

  AuthParameters({
    required this.username,
    required this.password,
    required this.secretHash,
  });

  AuthParameters copyWith({
    String? username,
    String? password,
    String? secretHash,
  }) =>
      AuthParameters(
        username: username ?? this.username,
        password: password ?? this.password,
        secretHash: secretHash ?? this.secretHash,
      );

  factory AuthParameters.fromJson(Map<String, dynamic> json) => AuthParameters(
        username: json["USERNAME"],
        password: json["PASSWORD"],
        secretHash: json["SECRET_HASH"],
      );

  Map<String, dynamic> toJson() => {
        "USERNAME": username,
        "PASSWORD": password,
        "SECRET_HASH": secretHash,
      };
}
