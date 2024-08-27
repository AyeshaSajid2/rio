// To parse this JSON data, do
//
//     final adminLoginModel = adminLoginModelFromJson(jsonString);

import 'dart:convert';

AdminLoginModel adminLoginModelFromJson(String str) =>
    AdminLoginModel.fromJson(json.decode(str));

String adminLoginModelToJson(AdminLoginModel data) =>
    json.encode(data.toJson());

class AdminLoginModel {
  final String? status;
  final String? event;
  final String? time;
  final String? token;
  final int? systemUsingTime;
  final String? deviceToken;
  final int? move;
  final bool? forgotPassword;

  AdminLoginModel({
    this.status,
    this.event,
    this.time,
    this.token,
    this.systemUsingTime,
    this.deviceToken,
    this.move,
    this.forgotPassword,
  });

  factory AdminLoginModel.fromJson(Map<String, dynamic> json) =>
      AdminLoginModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        token: json["token"],
        systemUsingTime: json["system_using_time"],
        deviceToken: json["device_token"],
        move: json["move"],
        forgotPassword: json["forgot_password"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "token": token,
        "system_using_time": systemUsingTime,
        "device_token": deviceToken,
        "move": move,
        "forgot_password": forgotPassword,
      };
}
