// To parse this JSON data, do
//
//     final adminLoginParam = adminLoginParamFromJson(jsonString);

import 'dart:convert';

AdminLoginParam adminLoginParamFromJson(String str) =>
    AdminLoginParam.fromJson(json.decode(str));

String adminLoginParamToJson(AdminLoginParam data) =>
    json.encode(data.toJson());

class AdminLoginParam {
  String username;
  String password;
  String deviceToken;
  String rioPassword;
  String mailId;

  AdminLoginParam({
    required this.username,
    required this.password,
    required this.deviceToken,
    required this.rioPassword,
    required this.mailId,
  });

  AdminLoginParam copyWith({
    String? username,
    String? password,
    String? deviceToken,
    String? rioPassword,
    String? mailId,
  }) =>
      AdminLoginParam(
        username: username ?? this.username,
        password: password ?? this.password,
        deviceToken: deviceToken ?? this.deviceToken,
        rioPassword: rioPassword ?? this.rioPassword,
        mailId: mailId ?? this.mailId,
      );

  factory AdminLoginParam.fromJson(Map<String, dynamic> json) =>
      AdminLoginParam(
        username: json["username"],
        password: json["password"],
        deviceToken: json["device_token"],
        rioPassword: json["rio_password"],
        mailId: json["mail_id"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "device_token": deviceToken,
        "rio_password": rioPassword,
        "mail_id": mailId,
      };
}
