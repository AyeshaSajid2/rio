// To parse this JSON data, do
//
//     final getUserModel = getUserModelFromJson(jsonString);

import 'dart:convert';

import '../../params/sign_up_apis/user_sign_up_param.dart';

GetUserModel getUserModelFromJson(String str) =>
    GetUserModel.fromJson(json.decode(str));

String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());

class GetUserModel {
  final List<UserAttribute>? userAttributes;
  final String? username;

  GetUserModel({
    this.userAttributes,
    this.username,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
        userAttributes: json["UserAttributes"] == null
            ? []
            : List<UserAttribute>.from(
                json["UserAttributes"]!.map((x) => UserAttribute.fromJson(x))),
        username: json["Username"],
      );

  Map<String, dynamic> toJson() => {
        "UserAttributes": userAttributes == null
            ? []
            : List<dynamic>.from(userAttributes!.map((x) => x.toJson())),
        "Username": username,
      };
}
