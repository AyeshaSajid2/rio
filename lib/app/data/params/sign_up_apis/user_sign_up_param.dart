// To parse this JSON data, do
//
//     final userSignUpParam = userSignUpParamFromJson(jsonString);

import 'dart:convert';

UserSignUpParam userSignUpParamFromJson(String str) =>
    UserSignUpParam.fromJson(json.decode(str));

String userSignUpParamToJson(UserSignUpParam data) =>
    json.encode(data.toJson());

class UserSignUpParam {
  String username;
  String password;
  String secretHash;
  String clientId;
  List<UserAttribute> userAttributes;

  UserSignUpParam({
    required this.username,
    required this.password,
    required this.secretHash,
    required this.clientId,
    required this.userAttributes,
  });

  UserSignUpParam copyWith({
    String? username,
    String? password,
    String? secretHash,
    String? clientId,
    List<UserAttribute>? userAttributes,
  }) =>
      UserSignUpParam(
        username: username ?? this.username,
        password: password ?? this.password,
        secretHash: secretHash ?? this.secretHash,
        clientId: clientId ?? this.clientId,
        userAttributes: userAttributes ?? this.userAttributes,
      );

  factory UserSignUpParam.fromJson(Map<String, dynamic> json) =>
      UserSignUpParam(
        username: json["Username"],
        password: json["Password"],
        secretHash: json["SecretHash"],
        clientId: json["ClientId"],
        userAttributes: List<UserAttribute>.from(
            json["UserAttributes"].map((x) => UserAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "Password": password,
        "SecretHash": secretHash,
        "ClientId": clientId,
        "UserAttributes":
            List<dynamic>.from(userAttributes.map((x) => x.toJson())),
      };
}

class UserAttribute {
  String name;
  String value;

  UserAttribute({
    required this.name,
    required this.value,
  });

  UserAttribute copyWith({
    String? name,
    String? value,
  }) =>
      UserAttribute(
        name: name ?? this.name,
        value: value ?? this.value,
      );

  factory UserAttribute.fromJson(Map<String, dynamic> json) => UserAttribute(
        name: json["Name"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Value": value,
      };
}
