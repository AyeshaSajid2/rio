// To parse this JSON data, do
//
//     final setApiAccountParam = setApiAccountParamFromJson(jsonString);

import 'dart:convert';

SetApiAccountParam setApiAccountParamFromJson(String str) =>
    SetApiAccountParam.fromJson(json.decode(str));

String setApiAccountParamToJson(SetApiAccountParam data) =>
    json.encode(data.toJson());

class SetApiAccountParam {
  String host;
  String key;
  String account;
  String password;
  String passwordEncode;

  SetApiAccountParam({
    required this.host,
    required this.key,
    required this.account,
    required this.password,
    required this.passwordEncode,
  });

  SetApiAccountParam copyWith({
    String? host,
    String? key,
    String? account,
    String? password,
    String? passwordEncode,
  }) =>
      SetApiAccountParam(
        host: host ?? this.host,
        key: key ?? this.key,
        account: account ?? this.account,
        password: password ?? this.password,
        passwordEncode: passwordEncode ?? this.passwordEncode,
      );

  factory SetApiAccountParam.fromJson(Map<String, dynamic> json) =>
      SetApiAccountParam(
        host: json["host"],
        key: json["key"],
        account: json["account"],
        password: json["password"],
        passwordEncode: json["password_encode"],
      );

  Map<String, dynamic> toJson() => {
        "host": host,
        "key": key,
        "account": account,
        "password": password,
        "password_encode": passwordEncode,
      };
}
