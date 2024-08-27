// To parse this JSON data, do
//
//     final getVpnLoginStatusModel = getVpnLoginStatusModelFromJson(jsonString);

import 'dart:convert';

GetVpnLoginStatusModel getVpnLoginStatusModelFromJson(String str) =>
    GetVpnLoginStatusModel.fromJson(json.decode(str));

String getVpnLoginStatusModelToJson(GetVpnLoginStatusModel data) =>
    json.encode(data.toJson());

class GetVpnLoginStatusModel {
  final String? status;
  final String? event;
  final String? time;
  final String? loginStatus;
  final String? loginStatusStr;

  GetVpnLoginStatusModel({
    this.status,
    this.event,
    this.time,
    this.loginStatus,
    this.loginStatusStr,
  });

  factory GetVpnLoginStatusModel.fromJson(Map<String, dynamic> json) =>
      GetVpnLoginStatusModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        loginStatus: json["login_status"],
        loginStatusStr: json["login_status_str"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "login_status": loginStatus,
        "login_status_str": loginStatusStr,
      };
}
