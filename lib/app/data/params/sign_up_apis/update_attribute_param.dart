// To parse this JSON data, do
//
//     final updateAttributeParam = updateAttributeParamFromJson(jsonString);

import 'dart:convert';

import 'user_sign_up_param.dart';

UpdateAttributeParam updateAttributeParamFromJson(String str) =>
    UpdateAttributeParam.fromJson(json.decode(str));

String updateAttributeParamToJson(UpdateAttributeParam data) =>
    json.encode(data.toJson());

class UpdateAttributeParam {
  String username;
  String clientId;
  String accessToken;
  List<UserAttribute> userAttributes;

  UpdateAttributeParam({
    required this.username,
    required this.clientId,
    required this.accessToken,
    required this.userAttributes,
  });

  UpdateAttributeParam copyWith({
    String? username,
    String? clientId,
    String? accessToken,
    List<UserAttribute>? userAttributes,
  }) =>
      UpdateAttributeParam(
        username: username ?? this.username,
        clientId: clientId ?? this.clientId,
        accessToken: accessToken ?? this.accessToken,
        userAttributes: userAttributes ?? this.userAttributes,
      );

  factory UpdateAttributeParam.fromJson(Map<String, dynamic> json) =>
      UpdateAttributeParam(
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
