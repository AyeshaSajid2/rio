// To parse this JSON data, do
//
//     final getUserParam = getUserParamFromJson(jsonString);

import 'dart:convert';

import 'user_sign_up_param.dart';

GetUserParam getUserParamFromJson(String str) =>
    GetUserParam.fromJson(json.decode(str));

String getUserParamToJson(GetUserParam data) => json.encode(data.toJson());

class GetUserParam {
  String username;
  String clientId;
  String accessToken;
  List<UserAttribute> userAttributes;

  GetUserParam({
    required this.username,
    required this.clientId,
    required this.accessToken,
    required this.userAttributes,
  });

  GetUserParam copyWith({
    String? username,
    String? clientId,
    String? accessToken,
    List<UserAttribute>? userAttributes,
  }) =>
      GetUserParam(
        username: username ?? this.username,
        clientId: clientId ?? this.clientId,
        accessToken: accessToken ?? this.accessToken,
        userAttributes: userAttributes ?? this.userAttributes,
      );

  factory GetUserParam.fromJson(Map<String, dynamic> json) => GetUserParam(
        username: json["Username"],
        clientId: json["ClientId"],
        accessToken: json["AccessToken"],
        userAttributes: List<UserAttribute>.from(
            json["UserAttributes"].map((x) => UserAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "ClientId": clientId,
        "AccessToken": accessToken,
        "UserAttributes":
            List<dynamic>.from(userAttributes.map((x) => x.toJson())),
      };
}
