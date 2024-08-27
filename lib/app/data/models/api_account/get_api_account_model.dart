// To parse this JSON data, do
//
//     final getApiAccountModel = getApiAccountModelFromJson(jsonString);

import 'dart:convert';

GetApiAccountModel getApiAccountModelFromJson(String str) =>
    GetApiAccountModel.fromJson(json.decode(str));

String getApiAccountModelToJson(GetApiAccountModel data) =>
    json.encode(data.toJson());

class GetApiAccountModel {
  final String? status;
  final String? event;
  final String? time;
  final String? host;
  final String? key;
  final String? account;
  final String? password;
  final String? passwordEncode;

  GetApiAccountModel({
    this.status,
    this.event,
    this.time,
    this.host,
    this.key,
    this.account,
    this.password,
    this.passwordEncode,
  });

  factory GetApiAccountModel.fromJson(Map<String, dynamic> json) =>
      GetApiAccountModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        host: json["host"],
        key: json["key"],
        account: json["account"],
        password: json["password"],
        passwordEncode: json["password_encode"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "host": host,
        "key": key,
        "account": account,
        "password": password,
        "password_encode": passwordEncode,
      };
}
